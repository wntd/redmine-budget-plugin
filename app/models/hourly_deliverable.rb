class HourlyDeliverable < Deliverable
  unloadable
  
  def spent
    return 0 unless self.issues.size > 0
    total = 0.0
    
    # Get all timelogs assigned
    time_logs = self.issues.collect(&:time_entries).flatten
    
    # Find each Member for their rate
    time_logs.each do |time_log|
      member = Member.find_by_user_id_and_project_id(time_log.user_id, time_log.project_id)
      total += (member.rate * time_log.hours) unless member.nil? || member.rate.nil?
    end
    
    return total
  end
end
