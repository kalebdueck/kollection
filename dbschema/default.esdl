module default {
	type Card {
		required property name -> str;
		property scryfall_id -> uuid;
		property scryfall_data -> json;
	}

	type Collection {
		multi link cards -> Card;
	}

	type Format {
		required property name -> str;
		required property mainboard_min -> int64;
		required property sideboard_min -> int64;
	}

	type Deck {
		required property name -> str;
		link format -> Format;
		multi link mainboard -> Card;
		multi link sideboard -> Card;
	}

	type User {
		required property email -> str;
		required property password -> str;
		link collection -> Collection;
	}
}
