%dw 2.0
output application/json

fun getWorkerId(worker) = 
  (worker.Worker_Reference.ID filter (item) -> item."type" == "Employee_ID")[0].value default 
  worker.Worker_Reference.ID[0].value default
  worker.Worker_Reference.ID.value

fun getAddressLine(addressData, descriptorVal) = 
  (addressData.Address_Line_Data filter (item) -> item.descriptor == descriptorVal)[0].value
---
{
  workerId: getWorkerId(payload.Worker),
  (salesforceUserId: payload.Worker.Salesforce_User_ID) if payload.Worker.Salesforce_User_ID != null,
  firstName: payload.Worker.Worker_Data.Personal_Data.Name_Data.Legal_Name_Data.Name_Detail_Data.First_Name,
  lastName: payload.Worker.Worker_Data.Personal_Data.Name_Data.Legal_Name_Data.Name_Detail_Data.Last_Name,
  email: payload.Worker.Worker_Data.Personal_Data.Contact_Data.Email_Address_Data[0].Email_Address,
  (phone: payload.Worker.Worker_Data.Personal_Data.Contact_Data.Phone_Data[0].Phone_Number) if payload.Worker.Worker_Data.Personal_Data.Contact_Data.Phone_Data != null,
  hireDate: payload.Worker.Worker_Data.Employment_Data.Worker_Status_Data.Hire_Date,
  employmentStatus: if (payload.Worker.Worker_Data.Employment_Data.Worker_Status_Data.Active == true) "Active" else "Inactive",
  workerType: payload.Worker.Worker_Data.Employment_Data.Worker_Type default "Regular",
  jobProfile: payload.Worker.Worker_Data.Employment_Data.Worker_Job_Data[0].Position_Data.Job_Profile_Summary_Data.Job_Profile_Name,
  department: payload.Worker.Worker_Data.Employment_Data.Worker_Job_Data[0].Position_Data.Business_Site_Summary_Data.Name,
  (managerId: (payload.Worker.Worker_Data.Employment_Data.Worker_Job_Data[0].Position_Data.Manager_as_of_last_detected_manager_change_Reference.ID filter (item) -> item."type" == "Employee_ID")[0].value) if payload.Worker.Worker_Data.Employment_Data.Worker_Job_Data[0].Position_Data.Manager_as_of_last_detected_manager_change_Reference != null,
  (workLocation: do {
    var addr = payload.Worker.Worker_Data.Personal_Data.Address_Data[0]
    ---
    {
      line1: getAddressLine(addr, "Address Line 1"),
      (line2: getAddressLine(addr, "Address Line 2")) if getAddressLine(addr, "Address Line 2") != null,
      city: addr.Municipality,
      (state: addr.Region) if addr.Region != null,
      (postalCode: addr.Postal_Code) if addr.Postal_Code != null,
      country: (addr.Country_Reference.ID filter (item) -> item."type" == "ISO_3166-1_Alpha-3_Code")[0].value default addr.Country_Reference.ID[0].value default addr.Country_Reference.ID.value
    }
  }) if payload.Worker.Worker_Data.Personal_Data.Address_Data != null
}
