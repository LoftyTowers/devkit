// See examples/dotnet/layered-microservice for the canonical layered structure.
namespace DevKit.Examples.ProblemDetails;

public class Result
{
    public bool IsSuccess { get; }
    public ErrorCode? Code { get; }
    public IReadOnlyList<string> Errors { get; }

    protected Result(bool ok, ErrorCode? code = null, IEnumerable<string>? errors = null)
    {
        IsSuccess = ok;
        Code = code;
        Errors = (errors ?? Array.Empty<string>()).ToArray();
    }

    public static Result Success() => new(true);

    public static Result Failure(ErrorCode code, params string[] errors) =>
        new(false, code, errors);
}

public class Result<T> : Result
{
    public T? Value { get; }

    protected Result(bool ok, T? value = default, ErrorCode? code = null, IEnumerable<string>? errors = null)
        : base(ok, code, errors)
    {
        Value = value;
    }

    public static Result<T> Success(T value) => new(true, value);
    public static Result<T> Failure(ErrorCode code, IEnumerable<string> errors) => new(false, default, code, errors);
}

/// <summary>
/// Extension methods mapping <see cref="Result"/> to <see cref="IActionResult"/>.
/// </summary>
public static class HttpResultMappingExtensions
{
    public static IActionResult ToActionResult(this ControllerBase ctrl, Result r)
    {
        if (r.IsSuccess) return ctrl.Ok();

        var code = r.Code ?? ErrorCode.Unexpected;
        var status = code.ToStatus();
        var title = code.GetTitle();

        var pd = new ProblemDetails
        {
            Status = status,
            Title  = title,
            Detail = string.Join("; ", r.Errors)
        };

        return new ObjectResult(pd) { StatusCode = status };
    }

    public static IActionResult ToActionResult<T>(this ControllerBase ctrl, Result<T> r)
    {
        if (r.IsSuccess) return ctrl.Ok(r.Value);
        return ToActionResult(ctrl, Result.Failure(r.Code ?? ErrorCode.Unexpected, r.Errors));
    }
}
