use nom::{
    branch::alt,
    bytes::complete::tag,
    bytes::complete::take_while,
    character::complete::{char, multispace1},
    multi::separated_list0,
    sequence::{delimited, preceded},
    IResult,
};

#[derive(Default)]
struct FunctionSignature {
    name: String,
    args: Vec<String>,
}

fn identifier(input: &str) -> IResult<&str, &str> {
    take_while(|c: char| c.is_alphanumeric() || c == '_')(input)
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

fn function(input: &str) -> IResult<&str, FunctionSignature> {
    let (input, signature) = function_signature(input)?;
    let (input, _) = alt((tag("endfunction()"), multispace1, identifier))(input)?;
    Ok((input, signature))
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
