%dw 2.0
output application/json
---
{
  workerId: payload.Onboarding_Response.Worker_Reference.ID.value default payload.Onboarding_Response.Worker_Reference.ID[0].value,
  communityUserEnabled: payload.Onboarding_Response.Onboarding_Data.Community_User_Enabled default false,
  onboardingStatus: payload.Onboarding_Response.Onboarding_Data.Status default "Pending",
  startDate: payload.Onboarding_Response.Onboarding_Data.Start_Date,
  assignedTasks: (payload.Onboarding_Response.Onboarding_Data.Tasks default []) map (task) -> task.Task_Name
}
