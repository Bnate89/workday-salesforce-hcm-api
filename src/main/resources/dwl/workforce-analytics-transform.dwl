%dw 2.0
output application/json
---
{
  department: payload.Workforce_Analytics.Department,
  headcount: payload.Workforce_Analytics.Headcount,
  totalCompensation: payload.Workforce_Analytics.Total_Compensation,
  currency: payload.Workforce_Analytics.Currency,
  lastUpdated: payload.Workforce_Analytics.Last_Updated
}
