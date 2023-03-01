if Rails.env.development? && !Rails.application.config.cache_classes
  Rails.autoloaders.main.on_unload do |_klass, _abspath|
    Rails.cache.clear
  end
end
