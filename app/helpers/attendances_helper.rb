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
end
