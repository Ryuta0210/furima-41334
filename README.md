#テーブル設計

##Usersテーブル
| Column              | Type      | Options                  |
|---------------------|-----------|--------------------------|
| email               | string    | null:false, unique:true  |
| encrypted_password  | string    | null:false               |
| nickname            | string    | null:false               |
| first_name          | string    | null:false               |
| family_name         | string    | null:false               |
| first_kana_name     | string    | null:false               |
| family_kana_name    | string    | null:false               |
| birth_day           | date      | null:false               |
| item                | reference | null:false, foreign_key  |


###Association
has_many :purchases
has_many :items


##Itemsテーブル
| Column              | Type      | Options                 |
|---------------------|-----------|-------------------------|
| name                | string    | null:false              |
| category_id         | integer   | null:false              |
| description         | text      | null:false              |
| status_id           | integer   | null:false              |
| shipping_cost_id    | integer   | null:false              |
| prefecture_id       | integer   | null:false              |
| delivery_schedule_id| integer   | null:false              |
| price               | string    | null:false              |
| user                | reference | null:false, foreign_key |

###Association
has_many :purchases
belongs_to :user


##purchasesテーブル
| Column              | Type      | Options                  |
|---------------------|-----------|--------------------------|
| item                | reference | null:false, foreign_key  |
| user                | reference | null:false, foreign_key  |

###Association
has_one :destination
belongs_to :item
belongs_to :user


##destinationsテーブル
| Column              | Type      | Options                  |
|---------------------|-----------|--------------------------|
| post_code           | integer   | null:false               |
| prefecture_id       | integer   | null:false               |
| city                | string    | null:false               |
| street              | string    | null:false               |
| building            | string    | null:false               |
| phone               | integer   | null:false               |

###Association
belongs_to :purchase