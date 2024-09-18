#テーブル設計

##Userテーブル
| Column              | Type    | Options           |
|---------------------|---------|-------------------|
| email               | string  | not null, unique  |
| encrypted_password  | string  | not null          |

###Association
has_many :purchases
has_one :profile


##Profileテーブル
| Column              | Type      | Options               |
|---------------------|-----------|-----------------------|
| nickname            | string    | not null              |
| first_name          | string    | not null              |
| family_name         | string    | not null              |
| first_kana_name     | string    | not null              |
| family_kana_name    | string    | not null              |
| birth_day           | date      | not null              |
| user                | reference | not null, foreign_key |

###Association
belongs_to :user


##Itemテーブル
| Column              | Type      | Options               |
|---------------------|-----------|-----------------------|
| name                | string    | not null              |
| description         | text      | not null              |
| status              | string    | not null              |
| shipping_cost       | string    | not null              |
| origin              | string    | not null              |
| delivery_schedule   | string    | not null              |
| price               | string    | not null              |
| category            | reference | not null, foreign_key |

###Association
has_many :purchases
belongs_to :category


##Categoryテーブル
| Column              | Type      | Options           |
|---------------------|-----------|-------------------|
| name                | string    | not null          |

###Association
has_many :items


##purchaseテーブル
| Column              | Type      | Options                |
|---------------------|-----------|------------------------|
| credit_card         | string    | not null               |
| destination         | reference | not null, foreign_key  |

###Association
has_one :destination


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