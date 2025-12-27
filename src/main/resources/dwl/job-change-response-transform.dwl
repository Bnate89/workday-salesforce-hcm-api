%dw 2.0
output application/json
---
{
  workerId: payload.Job_Change_Response.Worker_Reference.ID.value default payload.Job_Change_Response.Worker_Reference.ID[0].value,
  previousJobProfile: payload.Job_Change_Response.Job_Change_Data.Previous_Job_Profile,
  newJobProfile: payload.Job_Change_Response.Job_Change_Data.New_Job_Profile,
  effectiveDate: payload.Job_Change_Response.Job_Change_Data.Effective_Date,
  reason: payload.Job_Change_Response.Job_Change_Data.Reason
}
