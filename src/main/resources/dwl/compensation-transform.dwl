%dw 2.0
output application/json
---
{
  Compensation_Request: {
    Worker_Reference: {
      ID: {
        "type": "Employee_ID",
        value: payload.workerId
      }
    },
    Compensation_Data: {
      Base_Pay: {
        Amount: payload.baseSalary,
        Currency_Reference: {
          ID: {
            "type": "Currency_ID",
            value: payload.currency
          }
        },
        Frequency_Reference: {
          ID: {
            "type": "Frequency_ID",
            value: payload.payFrequency
          }
        }
      },
      Bonus_Eligible: payload.bonusEligible,
      Effective_Date: payload.effectiveDate
    }
  }
}
