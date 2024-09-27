# テーブル設計

## Usersテーブル
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


### Association
has_many :purchases
has_many :items


## Itemsテーブル
| Column              | Type      | Options                      |
|---------------------|-----------|------------------------------|
| name                | string    | null:false                   |
| category_id         | integer   | null:false                   |
| description         | text      | null:false                   |
| status_id           | integer   | null:false                   |
| shipping_cost_id    | integer   | null:false                   |
| prefecture_id       | integer   | null:false                   |
| delivery_schedule_id| integer   | null:false                   |
| price               | integer   | null:false                   |
| user                | references| null:false, foreign_key:true |

### Association
has_one :purchase
belongs_to :user


## Ordersテーブル
| Column              | Type      | Options                       |
|---------------------|-----------|-------------------------------|
| item                | references| null:false, foreign_key:true  |
| user                | references| null:false, foreign_key:true  |

### Association
has_one :destination
belongs_to :item
belongs_to :user


## Destinationsテーブル
| Column              | Type      | Options                       |
|---------------------|-----------|-------------------------------|
| post_code           | string    | null:false                    |
| prefecture_id       | integer   | null:false                    |
| city                | string    | null:false                    |
| street              | string    | null:false                    |
| building            | string    |                               |
| phone               | string    | null:false                    |
| purchase            | references| null:false, foreign_key:true  |

### Association
belongs_to :purchase