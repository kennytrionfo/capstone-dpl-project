class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  after_create :give_goals_to_user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
# took out the :confirmable for devise

  def self.find_or_create_by_omniauth(auth)
      where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name
    end
  end

  has_many :goals
  enum role: [:client, :admin]
  validates :username, :email, :encrypted_password, presence: true

  #
  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end

  def give_goals_to_user
      self.goals.create(category: "Use my own bags at the store", point_value: 12, frequency: 0, weekly_points_goal: 0, weekly_results: 0)
      self.goals.create(category: "Carpool instead of use my car", point_value: 100, frequency: 0, weekly_points_goal: 0, weekly_results: 0)
      self.goals.create(category: "Air dry a load of laundry", point_value: 70, frequency: 0, weekly_points_goal: 0, weekly_results: 0)
      self.goals.create(category: "Adjust the thermostat up 1 degree in summer", point_value: 40, frequency: 0, weekly_points_goal: 0, weekly_results: 0)
      self.goals.create(category: "Install a compact fluorescent light bulb", point_value: 60, frequency: 0, weekly_points_goal: 0, weekly_results: 0)
      self.goals.create(category: "Ride a bike instead of car 1 mile", point_value: 20, frequency: 0, weekly_points_goal: 0, weekly_results: 0)
      self.goals.create(category: "Take a shorter shower (5 min or less)", point_value: 4, frequency: 0, weekly_points_goal: 0, weekly_results: 0)
      self.goals.create(category: "Turn off my engine instead of idleing", point_value: 15, frequency: 0, weekly_points_goal: 0, weekly_results: 0)
      self.goals.create(category: "Buy or eat local", point_value: 15, frequency: 0, weekly_points_goal: 0, weekly_results: 0)


  end

end
