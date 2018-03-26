class User < ActiveRecord::Base

#マイクロポスト
 has_many :microposts, dependent: :destroy

# 出身地
  include JpPrefecture
jp_prefecture :prefecture_code

def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

# 画像アップロード
  mount_uploader :image, ImageUploader

#　性別
enum gender: {男: 1, 女: 2}
attr_accessor :remember_token
before_save { self.userid = userid.downcase }

#　年齢
def age
  date_format = "%Y%m%d"
  (Date.today.strftime(date_format).to_i - birthday.strftime(date_format).to_i) / 10000
end

# 制限
 has_secure_password
  validates :userid,  presence: true
  validates :name,  presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }

# ユーザー名による検索
scope :get_by_name, ->(name) {
where("name like ?", "%#{name}%")
}

# 性別による検索
scope :get_by_gender, ->(gender) {
where(gender: gender)
}

# 与えられた文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

# ランダムなトークンを返す
def User.new_token
  SecureRandom.urlsafe_base64
end

# ログイン情報を記録
def remember
  self.remember_token = User.new_token
  update_attribute(:remember_digest, User.digest(remember_token))
end

# 渡されたトークンがダイジェストと一致したらtrueを返す
def authenticated?(remember_token)
  return false if remember_digest.nil?
  BCrypt::Password.new(remember_digest).is_password?(remember_token)
end

# ログアウト
def forget
  update_attribute(:remember_digest, nil)
end
end
