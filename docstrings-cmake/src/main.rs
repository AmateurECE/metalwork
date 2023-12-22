use nom::{
    bytes::complete::tag,
    bytes::complete::take_while,
    character::complete::{char, multispace1},
    multi::separated_list0,
    sequence::{delimited, pair, preceded, terminated},
    IResult, branch::alt,
};

#[derive(Default)]
struct FunctionSignature {
    name: String,
    args: Vec<String>,
}

fn identifier(input: &str) -> IResult<&str, &str> {
    take_while(|c: char| c.is_alphanumeric() || c == '_' || c == '.' || c == '-')(input)
}

fn function_call(name: &str) -> impl Fn(&str) -> IResult<&str, Vec<&str>> {
    let name = name.to_string();
    move |input: &str| {
        let (input, mut args) = preceded(
            tag(name.as_str()),
            delimited(
                char('('),
                separated_list0(multispace1, identifier),
                char(')'),
            ),
        )(input)?;
        if args.get(0) == Some("").as_ref() {
            args.remove(0);
        }
        Ok((input, args))
    }
}

fn function_expression(input: &str) -> IResult<&str, ()> {
    preceded(
        identifier,
        delimited(
            char('('),
            separated_list0(multispace1, identifier),
            char(')'),
        ),
    )(input)
    .map(|(i, _)| (i, ()))
}

fn function_signature(input: &str) -> IResult<&str, FunctionSignature> {
    let (result, mut args) = function_call("function")(input)?;
    if args.is_empty() {
        return Err(nom::Err::Error(nom::error::Error {
            input,
            code: nom::error::ErrorKind::Char,
        }));
    }
    Ok((
        result,
        FunctionSignature {
            name: args.remove(0).to_string(),
            args: args.iter().map(|s| s.to_string()).collect::<Vec<String>>(),
        },
    ))
}

fn endfunction(input: &str) -> IResult<&str, ()> {
    tag("endfunction()")(input).map(|(i, _)| (i, ()))
}

fn function(input: &str) -> IResult<&str, FunctionSignature> {
    terminated(
        function_signature,
        pair(
            multispace1,
            separated_list0(multispace1, alt((
                endfunction,
                function_expression,
            ))),
        ),
    )(input)
}

fn main() {
    unimplemented!()
}

#[test]
fn one_arg_function_signature() {
    let (input, signature) = function_signature("function(TEST ARG1)").expect("Error parsing");
    assert_eq!(input, "");
    assert_eq!(&signature.name, "TEST");
    assert_eq!(signature.args, vec!["ARG1".to_string()]);
}

#[test]
fn simple_function_expression() {
    let (input, _) = function_expression("add_library(test test.c)").expect("Error parsing");
    assert_eq!(input, "");
}

#[test]
fn no_arg_function_signature() {
    let (input, signature) = function_signature("function(TEST)").expect("Error parsing");
    assert_eq!(input, "");
    assert_eq!(&signature.name, "TEST");
    assert!(signature.args.is_empty());
}

#[test]
fn no_arg_function_call() {
    let (input, args) = function_call("function")("function()").expect("Error parsing");
    assert_eq!(input, "");
    assert!(args.is_empty());
}

#[test]
fn simple_function() {
    let (input, signature) =
        function("function(TEST)\nadd_library(test test.c)\nendfunction()").expect("Error parsing");
    assert_eq!(input, "");
    assert_eq!(&signature.name, "TEST");
    assert!(signature.args.is_empty());
}
