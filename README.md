#テーブル設計

##Userテーブル
| Column              | Type    | Options           |
|---------------------|---------|-------------------|
| email               | string  | not null, unique  |
| encrypted_password  | string  | not null          |
| nickname            | string  | not null          |
| first_name          | string  | not null          |
| family_name         | string  | not null          |
| first_kana_name     | string  | not null          |
| family_kana_name    | string  | not null          |
| birth_day           | date    | not null          |

###Association
has_many :purchases


##Itemテーブル
| Column              | Type      | Options               |
|---------------------|-----------|-----------------------|
| name                | string    | not null              |
| category            | string    | not null              |
| description         | text      | not null              |
| status              | string    | not null              |
| shipping_cost       | string    | not null              |
| origin              | string    | not null              |
| delivery_schedule   | string    | not null              |
| price               | string    | not null              |

###Association
has_many :purchases


##purchaseテーブル
| Column              | Type      | Options                |
|---------------------|-----------|------------------------|
| credit_card         | string    | not null               |
| destination         | reference | not null, foreign_key  |
| item                | reference | not null, foreign_key  |
| user                | reference | not null, foreign_key  |

###Association
has_one :destination
belongs_to :item
belongs_to :user


##destinationテーブル
| Column              | Type      | Options                |
|---------------------|-----------|------------------------|
| post_code           | integer   | not null               |
| prefecture          | string    | not null               |
| city                | string    | not null               |
| street              | string    | not null               |
| building            | string    | not null               |
| phone               | integer   | not null               |

###Association
belongs_to :purchase