import { Context } from "https://deno.land/x/oak@v10.6.0/context.ts";
import * as edgedb from "https://deno.land/x/edgedb/mod.ts";

const index = async (ctx: Context) => {

    const client = edgedb.createClient();

    const response = await client.querySingle("SELECT 1 + <int64>$num", { num: 2 });

    await client.close();

    return ctx.response.body = response;
};

export default index;
