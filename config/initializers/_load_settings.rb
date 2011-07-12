if Rails.env=='production'
SETTINGS = {'twitter' => {},'facebook' => {},'linkedin' => {},'github' => {}, 'organization'=>{}, 'common'=> {}}
S3_KEY = ENV['S3_KEY']
S3_SECRET = ENV['S3_SECRET']
SETTINGS['twitter']['key']= ENV['twitter_key']
SETTINGS['twitter']['secret']= ENV['twitter_secret']
SETTINGS['linkedin']['key']= ENV['linkedin_key']
SETTINGS['linkedin']['secret']= ENV['linkedin_secret']
SETTINGS['github']['key']= ENV['github_key']
SETTINGS['github']['secret']= ENV['github_secret']
SETTINGS['facebook']['key']= ENV['facebook_key']
SETTINGS['facebook']['secret']= ENV['facebook_secret']
SETTINGS['common']['providers']= ['twitter','open_id','google','facebook','linked_in','github']
SETTINGS['organization']['name']= 'Org Name'
SETTINGS['organization']['city']= 'City'
SETTINGS['organization']['state']= 'State'
SETTINGS['organization']['url']= 'http://geeks.codeforamerica.org'
SETTINGS['organization']['twitter']= 'codeforamerica'
SETTINGS['organization']['email']= 'corps@codeforamerica.org'
SETTINGS['organization']['host']= 'heroku'
SETTINGS['organization']['host_url']= 'geeks@codeforamerica.org'
SETTINGS['organization']['logotype']= 'GeekCorps'
else
  # Load application settings from config/settings.yml
  settings_yml = HashWithIndifferentAccess.new(YAML.load_file(Rails.root.join('config', 'settings.yml')))

  merged_settings = settings_yml['common']
  merged_settings.deep_merge!(settings_yml[Rails.env]) if settings_yml.has_key?(Rails.env)

  SETTINGS = merged_settings
  
  S3_KEY = SETTINGS['s3']['access_key_id']
  S3_SECRET = SETTINGS['s3']['secret_access_key']
end

