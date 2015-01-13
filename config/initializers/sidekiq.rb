Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redistogo:7a0a2a87daad7f3408b80b6b67210cb7@mummichog.redistogo.com:10221' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redistogo:7a0a2a87daad7f3408b80b6b67210cb7@mummichog.redistogo.com:10221' }
end