import { Adapter, AdapterUser } from "next-auth/adapters"
import { Client, QueryArgumentError } from "edgedb"
import e, { $infer } from "../dbschema/edgeql-js"
import { Account } from "next-auth"

export default function EdgeDbAdapter(client: Client, options = {}): Adapter {
    return {

        async getUser(id): Promise<AdapterUser | null> {

            const selectUser = e.select(e.User, user => ({
                id: true,
                name: true,
                email: true,
                emailVerified: true,
                image: true,
                filter: e.op(user.id, '=', e.uuid(id)),
            }))

            const result = await selectUser.run(client)

            return result;
        },

        async getUserByEmail(email) {
            const selectUser = e.select(e.User, user => ({
                id: true,
                name: true,
                email: true,
                emailVerified: true,
                filter: e.op(user.email, '=', e.str(email)),
            }))

            const result = await selectUser.run(client)


            if (result === null) {
                return result;
            }
            return result[0];
        },

        async createUser(user) {
            console.log("Creating User")
            const { name, email, emailVerified, image } = user;

            const insertUser = e.insert(e.User, {
                name: e.str(name ?? ""),
                email: e.str(email ?? ""),
                emailVerified: emailVerified ? e.datetime(emailVerified) : null,
                image: e.str(image ?? ""),
            })

            const result = await insertUser.run(client)


            const selectUser = e.select(e.User, user => ({
                id: true,
                name: true,
                email: true,
                emailVerified: true,
                image: true,
                filter: e.op(user.id, '=', e.uuid(result.id)),
            }))

            const newUser = await selectUser.run(client)

            if (newUser !== null) {
                return newUser;
            }

            throw 'could not find user';
        },

        async getUserByAccount({ providerAccountId }) {
            const selectUser = e.select(e.User, () => ({
                id: true,
                name: true,
                email: true,
                emailVerified: true,
                account: account => ({
                    filter: e.op(account.providerAccountId, '=', providerAccountId)
                }),
            }))

            const result = await selectUser.run(client)

            if (result === null) {
                return result;
            }

            return result[0];
        },

        async updateUser(user) {
            if (!user.id) {
                throw 'user needs id';
            }

            const selectOldUser = e.select(e.User, oldUserData => ({
                id: true,
                name: true,
                email: true,
                emailVerified: true,
                image: true,
                filter: e.op(oldUserData.id, '=', e.uuid(user.id ?? '')),
            }))

            const oldUser = await selectOldUser.run(client)

            if (!oldUser) {
                throw 'user not found'
            }

            const newUser = {
                ...oldUser,
                ...user
            }

            const { id, name, email, emailVerified, image } = newUser;

            const updateUser = e.update(
                e.User,
                userObj => ({
                    filter: e.op(userObj.id, '=', e.uuid(id)),
                    set: {
                        name: e.str(name ?? ""),
                        email: e.str(email ?? ""),
                        emailVerified: e.datetime(emailVerified ?? ""),
                        image: e.str(image ?? ""),
                    },

                }),
            )

            const result = await updateUser.run(client)

            if (result === null) {
                throw 'user not updated'
            }

            const selectUser = e.select(e.User, user => ({
                id: true,
                name: true,
                email: true,
                emailVerified: true,
                image: true,
                filter: e.op(user.id, '=', e.uuid(id)),
            }))

            const selectResult = await selectUser.run(client)

            if (!selectResult) {
                throw 'error'
            }

            return selectResult;
        },

        async deleteUser(userId) {
            const deleteUser = e.delete(e.User, user => ({
                filter: e.op(user.id, '=', e.uuid(userId))
            }))

            await deleteUser.run(client)

            return
        },

        async linkAccount(account: Account) {
            console.log('Linking Account')

            const createAccount = e.insert(e.Account, {
                userId: account.userId, //TODO unneccisary, remove later
                provider: account.provider,
                provider_type: account.type,
                providerAccountId: account.providerAccountId,
                access_token: account.access_token,
                expires_at: account.expires_at,
                refresh_token: account.refresh_token,
                id_token: account.id_token,
                scope: account.scope,
                session_state: account.session_state,
                token_type: account.token_type,
            })

            const updateUser = e.update(e.User, user => ({
                filter: e.op(user.id, '=', e.uuid(account.userId)),
                set: {
                    account: { '+=': createAccount }
                }
            }))

            await updateUser.run(client)

            return
        },

        async unlinkAccount({ providerAccountId, provider }) {

            const deleteAccount = e.delete(e.Account,
                acc => ({
                    filter: e.op(acc.providerAccountId, '=', providerAccountId),
                })
            )

            await deleteAccount.run(client)

            return
        },


        //TODO single link on user i think.
        async createSession({ sessionToken, userId, expires }) {
            console.log("Creating Session")

            const createSession = e.insert(e.Session, {
                sessionToken: sessionToken,
                expires: expires
            }
            );

            const userUpdate = e.update(e.User, user => ({
                filter: e.op(user.id, '=', e.uuid(userId)),
                set: {
                    session: { '+=': createSession }

                }
            }))


            const result = await userUpdate.run(client)
            console.log(result)

            const userSession = e.select(e.User, user => ({
                filter: e.op(user.id, '=', e.uuid(userId)),
                session: {
                    id: true,
                    sessionToken: true,
                    expires: true,
                }
            }));

            const userResult = await userSession.run(client);

            if (!userResult) {
                throw 'could not find user'
            }

            console.log(userResult)

            return {
                ...userResult.session[0],
                userId
            }
        },

        async getSessionAndUser(sessionToken) {
            console.log(sessionToken)
            const userAndSession = e.select(e.User, user => ({
                id: true,
                name: true,
                email: true,
                emailVerified: true,
                image: true,
                session: session => ({
                    filter: e.op(session.sessionToken, '=', sessionToken),
                    id: true,
                    sessionToken: true,
                    expires: true,
                })
            }));
            console.log('got here?')

            const userAndSessionResult = await userAndSession.run(client);
            console.log(userAndSessionResult)
            if (userAndSessionResult.length === 0) {
                return null;
            }

            const userData = userAndSessionResult[0];
            const sessionData = userData.session[0];

            return {
                session: {
                    ...sessionData,
                    userId: userData.id
                },
                user: {
                    id: userData.id,
                    name: userData.name,
                    email: userData.email,
                    emailVerified: userData.emailVerified,
                    image: userData.image,
                },
            };
        },

        async updateSession(session) {
            const sessionUpdate = e.update(e.Session, sessionObj => ({
                filter: e.op(sessionObj.sessionToken, '=', session.sessionToken),
                set: {
                    ...session
                }
            }));

            const updateResult = await sessionUpdate.run(client);

            if (!updateResult) {
                throw "Session not updated";
            }

            const userSession = e.select(e.User, user => ({
                id: true,

                session: sessionObj => ({
                    id: true,
                    sessionToken: true,
                    expires: true,
                    filter: e.op(sessionObj.sessionToken, '=', session.sessionToken)
                })
            }));

            const userResult = await userSession.run(client);

            if (!userResult) {
                throw 'could not find user'
            }

            const userData = userResult[0];
            const sessionData = userData.session[0];

            return {
                ...sessionData,
                userId: userData.id
            }
        },
        async deleteSession(sessionToken) {

            const deleteSession = e.delete(e.Session, session => ({
                filter: e.op(session.sessionToken, '=', sessionToken)
            }))

            await deleteSession.run(client)

            return
        },
    }
}