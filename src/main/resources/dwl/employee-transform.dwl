%dw 2.0
output application/json
---
{
  Worker: {
    Worker_Reference: {
      ID: {
        "type": "Employee_ID",
        value: payload.workerId
      }
    },
    Worker_Data: {
      Personal_Data: {
        Name_Data: {
          Legal_Name_Data: {
            Name_Detail_Data: {
              First_Name: payload.firstName,
              Last_Name: payload.lastName
            }
          }
        },
        Contact_Data: {
          Email_Address_Data: [{
            Email_Address: payload.email,
            Usage_Data: {
              Type_Data: {
                Primary: true
              }
            }
          }],
          (Phone_Data: [{
            Phone_Number: payload.phone,
            Usage_Data: {
              Type_Data: {
                Primary: true
              }
            }
          }]) if payload.phone != null
        },
        (Address_Data: [{
          Address_Line_Data: [
            { descriptor: "Address Line 1", value: payload.workLocation.line1 },
            ({ descriptor: "Address Line 2", value: payload.workLocation.line2 }) if payload.workLocation.line2 != null
          ],
          Municipality: payload.workLocation.city,
          (Region: payload.workLocation.state) if payload.workLocation.state != null,
          (Postal_Code: payload.workLocation.postalCode) if payload.workLocation.postalCode != null,
          Country_Reference: {
            ID: {
              "type": "ISO_3166-1_Alpha-3_Code",
              value: payload.workLocation.country
            }
          }
        }]) if payload.workLocation != null
      },
      Employment_Data: {
        Worker_Status_Data: {
          Hire_Date: payload.hireDate,
          Active: payload.employmentStatus == "Active"
        },
        Worker_Job_Data: [{
          Position_Data: {
            Job_Profile_Summary_Data: {
              Job_Profile_Name: payload.jobProfile
            },
            Business_Site_Summary_Data: {
              Name: payload.department
            },
            (Manager_as_of_last_detected_manager_change_Reference: {
              ID: {
                "type": "Employee_ID",
                value: payload.managerId
              }
            }) if payload.managerId != null
          }
        }]
      }
    }
  }
}
