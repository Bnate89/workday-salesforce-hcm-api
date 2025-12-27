%dw 2.0
output application/json
---
{
  workerId: payload.Compensation_Response.Worker_Reference.ID.value default payload.Compensation_Response.Worker_Reference.ID[0].value,
  baseSalary: payload.Compensation_Response.Compensation_Data.Base_Pay.Amount,
  currency: payload.Compensation_Response.Compensation_Data.Base_Pay.Currency_Reference.ID.value default payload.Compensation_Response.Compensation_Data.Base_Pay.Currency_Reference.ID[0].value,
  payFrequency: payload.Compensation_Response.Compensation_Data.Base_Pay.Frequency_Reference.ID.value default payload.Compensation_Response.Compensation_Data.Base_Pay.Frequency_Reference.ID[0].value,
  bonusEligible: payload.Compensation_Response.Compensation_Data.Bonus_Eligible default false,
  effectiveDate: payload.Compensation_Response.Compensation_Data.Effective_Date
}
