namespace DevKit.Examples.ProblemDetails;

/// <summary>
/// Defines standard error codes aligned with HTTP status categories.
/// </summary>
public enum ErrorCode
{
    Validation = 400,
    Domain     = 422,
    Cancelled  = 499,
    Unexpected = 500
}

/// <summary>
/// Extension helpers for <see cref="ErrorCode"/> values.
/// </summary>
public static class ErrorCodeExtensions
{
    public static string GetTitle(this ErrorCode code) => code switch
    {
        ErrorCode.Validation => "Validation Failed",
        ErrorCode.Domain     => "Domain Error",
        ErrorCode.Cancelled  => "Request Cancelled",
        ErrorCode.Unexpected => "Unexpected Error",
        _ => "Unknown Error"
    };

    public static int ToStatus(this ErrorCode code) => (int)code;
}
