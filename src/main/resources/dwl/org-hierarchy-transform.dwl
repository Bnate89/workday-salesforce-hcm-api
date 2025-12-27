%dw 2.0
output application/json
---
{
  workerId: (payload.Worker.Worker_Reference.ID filter (item) -> item."type" == "Employee_ID")[0].value default payload.Worker.Worker_Reference.ID[0].value default payload.Worker.Worker_Reference.ID.value,
  (managerId: (payload.Worker.Organization_Data.Manager_Reference.ID filter (item) -> item."type" == "Employee_ID")[0].value) if payload.Worker.Organization_Data.Manager_Reference != null,
  department: (payload.Worker.Organization_Data.Organization_Reference.ID filter (item) -> item."type" == "Organization_ID")[0].value default payload.Worker.Organization_Data.Organization_Reference.ID[0].value default payload.Worker.Organization_Data.Organization_Reference.ID.value,
  (costCenter: (payload.Worker.Organization_Data.Cost_Center_Reference.ID filter (item) -> item."type" == "Cost_Center_ID")[0].value) if payload.Worker.Organization_Data.Cost_Center_Reference != null
}
