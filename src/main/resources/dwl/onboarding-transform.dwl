%dw 2.0
output application/json
---
{
  Onboarding_Request: {
    Worker_Reference: {
      ID: {
        "type": "Employee_ID",
        value: payload.workerId
      }
    },
    Onboarding_Data: {
      Community_User_Enabled: payload.communityUserEnabled,
      Status: payload.onboardingStatus,
      Start_Date: payload.startDate,
      Tasks: payload.assignedTasks map (task) -> {
        Task_Name: task,
        Status: "Pending"
      }
    }
  }
}
