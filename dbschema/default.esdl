module default {
	type Card {
		required property name -> str;
		property scryfall_id -> uuid;
		property scryfall_data -> json;

		# todo price history would be nice
		property price -> int64;
	}
	
	abstract link link_with_count {
		property count -> int64;
	}

	type Collection {
		multi link cards extending link_with_count -> Card 
	}

	type Format {
		required property name -> str;
		required property mainboard_min -> int64;
		required property sideboard_min -> int64;
	}

	type Deck {
		required property name -> str;
		link format -> Format;
		multi link mainboard extending link_with_count -> Card;
		multi link sideboard extending link_with_count -> Card;
	}

	type User {
		required property name -> str;
		required property email -> str;
		property emailVerified -> datetime;
		property image -> str;

		link collection -> Collection {
			constraint exclusive;
		};

		multi link account -> Account {
			constraint exclusive;
			on target delete allow;
			on source delete delete target
		}

		multi link session -> Session {
			constraint exclusive;
			on target delete allow;
			on source delete delete target
		}

		multi link verificationToken -> VerificationToken {
			constraint exclusive;
		}
	}

	type Account {
		required property provider -> str;
		required property providerAccountId -> str;
		property userId -> str;
        property provider_type -> str;
        property access_token -> str;
        property expires_at -> int64;
        property refresh_token -> str;
        property id_token -> str;
        property scope -> str;
        property session_state -> str;
        property token_type -> str;
        property refresh_token_expired_in -> int64;
	}

	type VerificationToken {
		required property identifier -> str;
		required property expires -> datetime;
		required property token -> str;
	}

	type Session {
		required property expires -> datetime;
		required property sessionToken -> str;
	}
}
