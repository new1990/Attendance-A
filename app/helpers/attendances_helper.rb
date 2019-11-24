module AttendancesHelper
  
  def attendance_attend(attendance)
    if Date.current == attendance.worked_on
      return '出社' if attendance.started_at.nil?
    end
    false
  end
  
  def attendance_leave(attendance)
    if Date.current == attendance.worked_on
      return '退社' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    false
  end
  
  # 本日の勤務中社員取得用
  def working_users
    User.where(id: Attendance.where.not(started_at: nil).
         where(id: Attendance.where(finished_at: nil)).
         where(id: Attendance.where(worked_on: Date.current)).select(:user_id))
  end
  
  def attendances_invalid?
    attendances = true
    attendances_params.each do |id, item|
      if item[:started_at].blank? && item[:finished_at].blank?
        next
      elsif item[:started_at].blank? || item[:finished_at].blank?
        attendances = false
        break
      elsif item[:started_at] > item[:finished_at]
        attendances = false
        break
      end
    end
    return attendances
  end
  
  def working_times(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))
  end
end
