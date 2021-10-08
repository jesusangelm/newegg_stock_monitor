namespace :newegg do
  desc 'Extract and save XSX stock from NewEgg'
  task xsx_stock: :environment do
    NeweggJob.perform_later(:xsx)
    Rails.logger.info '[INFO] XSX JOB QUEUED'
  end

  desc 'Extract and save XSS stock from NewEgg'
  task xss_stock: :environment do
    NeweggJob.perform_later(:xss)
    Rails.logger.info '[INFO] XSS JOB QUEUED'
  end
end
