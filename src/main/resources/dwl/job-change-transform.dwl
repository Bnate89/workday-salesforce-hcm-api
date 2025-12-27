%dw 2.0
output application/json
---
{
  Job_Change_Request: {
    Worker_Reference: {
      ID: {
        "type": "Employee_ID",
        value: payload.workerId
      }
    },
    Job_Change_Data: {
      Previous_Job_Profile: payload.previousJobProfile,
      New_Job_Profile: payload.newJobProfile,
      Effective_Date: payload.effectiveDate,
      Reason: payload.reason
    }
  }
}
