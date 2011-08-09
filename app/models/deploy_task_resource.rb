class DeployTaskResource < ActiveRecord::Base
  belongs_to :deploy_task
  has_many :comments, :as => :commentable
  belongs_to :team

end
