set :environment, "development"
set :output, {error: "log/cron_error_log.log", standard: "log/cron_log.log"}

every :day, at: "4:27pm" do
  rake "exam:check_exam_daily"
end

every "45 23 28-31 * * ['$(date +%d -d tomorrow)' = '01'] &&" do
  rake "exam:check_exam_monthly"
end
