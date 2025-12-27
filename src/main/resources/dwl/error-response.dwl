%dw 2.0
output application/json
---
{
  errorCode: vars.errorCode default "HR_INTERNAL_ERROR",
  message: vars.errorMessage default error.description default "An unexpected error occurred",
  correlationId: correlationId,
  timestamp: now() as String {format: "yyyy-MM-dd'T'HH:mm:ss'Z'"}
}
