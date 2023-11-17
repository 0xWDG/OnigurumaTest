//
//  TextMateDeclaration.swift
//  OnigurumaTest
//
//  Created by Wesley de Groot on 16/02/2023.
//

import Foundation

// MARK: - TextMateJSO
struct TextMateJSON: Codable {
    let informationForContributors: [String]
    let version: String
    let scopeName: String
    let patterns: [TextMateJSONPattern]
    let repository: Repository

    enum CodingKeys: String, CodingKey {
        case informationForContributors = "information_for_contributors"
        case version, scopeName, patterns, repository
    }
}

// MARK: - TextMateJSONPatter
struct TextMateJSONPattern: Codable {
    let include, match, name: String?
    let captures: [String: PurpleCapture]?
    let begin: String?
    let beginCaptures: [String: BeginCapture]?
    let end: String?
    let patterns: [PurplePattern]?
    let endCaptures: [String: EndCaptureValue]?
    let contentName: String?
}

// MARK: - BeginCapture
struct BeginCapture: Codable {
    let name: String?
    let patterns: [EndCapturePattern]?
}

// MARK: - EndCapturePattern
struct EndCapturePattern: Codable {
    let match, name, include: String?
}

// MARK: - PurpleCapture
struct PurpleCapture: Codable {
    let name: String?
    let patterns: [EndCapturePattern]?
}

// MARK: - EndCaptureValue
struct EndCaptureValue: Codable {
    let name: String?
    let patterns: [EndCapturePattern]?
}

// MARK: - PurplePattern
struct PurplePattern: Codable {
    let include, match, name: String?
    let captures: [String: FluffyCapture]?
    let begin: String?
    let beginCaptures: [String: BeginCapture]?
    let end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let patterns: [StringDoubleQuoted]?
    let contentName: String?
}

// MARK: - FluffyCapture
struct FluffyCapture: Codable {
    let patterns: [AttributeNamePattern]?
    let name: String?
}

// MARK: - AttributeNamePattern
struct AttributeNamePattern: Codable {
    let match, name, begin, end: String?
    let endCaptures: VarGlobalBeginCaptures?
    let patterns: [StringDoubleQuotedPattern]?
    let captures: VarGlobalBeginCaptures?
    let include: String?
}

// MARK: - VarGlobalBeginCaptures
struct VarGlobalBeginCaptures: Codable {
    let the1: The1?

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
    }
}

// MARK: - The1
struct The1: Codable {
    let name: String?
}

// MARK: - StringDoubleQuotedPattern
struct StringDoubleQuotedPattern: Codable {
    let include: String?
}

// MARK: - StringDoubleQuotedBeginCaptures
struct StringDoubleQuotedBeginCaptures: Codable {
    let the0: The1?

    enum CodingKeys: String, CodingKey {
        case the0 = "0"
    }
}

// MARK: - StringDoubleQuoted
struct StringDoubleQuoted: Codable {
    let include, match: String?
    let captures: [String: StringDoubleQuotedCapture]?
    let name, begin: String?
    let beginCaptures: StringDoubleQuotedBeginCaptures?
    let end: String?
    let patterns: [StringDoubleQuotedPattern]?
    let endCaptures: StringDoubleQuotedBeginCaptures?
}

// MARK: - StringDoubleQuotedCapture
struct StringDoubleQuotedCapture: Codable {
    let name: String?
    let patterns: [NullCoalescing]?
}

// MARK: - NullCoalescing
struct NullCoalescing: Codable {
    let match, name: String?
}

// MARK: - Repository
struct Repository: Codable {
    let attributeName: AttributeName?
    let attribute: Attribute?
    let classBuiltin: ClassBuiltin?
    let className: ClassName?
    let inheritanceSingle: AttributeName?
    let classExtends: ClassExtends?
    let interfaceExtends, classImplements: ClassImplements?
    let classConstant: ClassConstant?
    let comments: Comments?
    let constants: ClassBuiltin?
    let functionParameters: FunctionParameters?
    let namedArguments: NamedArguments?
    let functionCall: FunctionCall?
    let heredoc: ClassExtends?
    let heredocInterior, nowdocInterior: DocInterior?
    let instantiation: Instantiation?
    let interpolation: Interpolation?
    let interpolationDoubleQuoted: InterpolationDoubleQuoted?
    let invokeCall: InvokeCall?
    let namespace: Namespace?
    let numbers: Numbers?
    let object: Object?
    let phpTypes: InterpolationDoubleQuoted?
    let parameterDefaultTypes: ParameterDefaultTypes?
    let phpDoc: PHPDoc?
    let phpDocTypes: PHPDocTypes?
    let phpDocTypesArrayMultiple: PHPDocTypesArrayMultiple?
    let phpDocTypesArraySingle: PHPDocTypesArraySingle?
    let regexDoubleQuoted, regexSingleQuoted: RegexLEQuoted?
    let scopeResolution: ScopeResolution?
    let singleQuoteRegexEscape: NullCoalescing?
    let sqlStringDoubleQuoted: SQLStringDoubleQuoted?
    let sqlStringSingleQuoted: SQLStringSingleQuoted?
    let stringBacktick: StringBacktick?
    let stringDoubleQuoted: StringDoubleQuoted?
    let stringSingleQuoted: StringSingleQuoted?
    let strings: Strings?
    let support: Support?
    let switchStatement: SwitchStatement?
    let matchStatement: MatchStatement?
    let useInner: UseInner?
    let varBasic: ClassBuiltin?
    let varGlobal, varGlobalSafer, varLanguage: VarGlobal?
    let variableName: VariableName?
    let variables: Interpolation?
    let ternaryShorthand: NullCoalescing?
    let ternaryExpression: TernaryExpression?
    let nullCoalescing: NullCoalescing?

    enum CodingKeys: String, CodingKey {
        case attributeName = "attribute-name"
        case attribute
        case classBuiltin = "class-builtin"
        case className = "class-name"
        case inheritanceSingle = "inheritance-single"
        case classExtends = "class-extends"
        case interfaceExtends = "interface-extends"
        case classImplements = "class-implements"
        case classConstant = "class-constant"
        case comments, constants
        case functionParameters = "function-parameters"
        case namedArguments = "named-arguments"
        case functionCall = "function-call"
        case heredoc
        case heredocInterior = "heredoc_interior"
        case nowdocInterior = "nowdoc_interior"
        case instantiation, interpolation
        case interpolationDoubleQuoted = "interpolation_double_quoted"
        case invokeCall = "invoke-call"
        case namespace, numbers, object
        case phpTypes = "php-types"
        case parameterDefaultTypes = "parameter-default-types"
        case phpDoc = "php_doc"
        case phpDocTypes = "php_doc_types"
        case phpDocTypesArrayMultiple = "php_doc_types_array_multiple"
        case phpDocTypesArraySingle = "php_doc_types_array_single"
        case regexDoubleQuoted = "regex-double-quoted"
        case regexSingleQuoted = "regex-single-quoted"
        case scopeResolution = "scope-resolution"
        case singleQuoteRegexEscape = "single_quote_regex_escape"
        case sqlStringDoubleQuoted = "sql-string-double-quoted"
        case sqlStringSingleQuoted = "sql-string-single-quoted"
        case stringBacktick = "string-backtick"
        case stringDoubleQuoted = "string-double-quoted"
        case stringSingleQuoted = "string-single-quoted"
        case strings, support
        case switchStatement = "switch_statement"
        case matchStatement = "match_statement"
        case useInner = "use-inner"
        case varBasic = "var_basic"
        case varGlobal = "var_global"
        case varGlobalSafer = "var_global_safer"
        case varLanguage = "var_language"
        case variableName = "variable-name"
        case variables
        case ternaryShorthand = "ternary_shorthand"
        case ternaryExpression = "ternary_expression"
        case nullCoalescing = "null_coalescing"
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let begin, end, name: String?
    let patterns: [AttributePattern]?
}

// MARK: - AttributePattern
struct AttributePattern: Codable {
    let match, name, begin: String?
    let beginCaptures: [String: PHPDocTypesArraySingleCapture]?
    let end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let patterns: [StringDoubleQuotedPattern]?
    let include: String?
}

// MARK: - PHPDocTypesArraySingleCapture
struct PHPDocTypesArraySingleCapture: Codable {
    let patterns: [StringDoubleQuotedPattern]?
    let name: String?
}

// MARK: - AttributeName
struct AttributeName: Codable {
    let patterns: [AttributeNamePattern]?
}

// MARK: - ClassBuiltin
struct ClassBuiltin: Codable {
    let patterns: [VarGlobal]?
}

// MARK: - VarGlobal
struct VarGlobal: Codable {
    let match, name: String?
    let captures: VarGlobalBeginCaptures?
    let include: String?
}

// MARK: - ClassConstant
struct ClassConstant: Codable {
    let patterns: [NamedArguments]?
}

// MARK: - NamedArguments
struct NamedArguments: Codable {
    let match: String?
    let captures: [String: The1]?
}

// MARK: - ClassExtends
struct ClassExtends: Codable {
    let patterns: [ClassExtendsPattern]?
}

// MARK: - ClassExtendsPattern
struct ClassExtendsPattern: Codable {
    let begin: String?
    let beginCaptures: VarGlobalBeginCaptures?
    let end: String?
    let patterns: [StringDoubleQuotedPattern]?
    let name: String?
}

// MARK: - ClassImplements
struct ClassImplements: Codable {
    let patterns: [Instantiation]?
}

// MARK: - Instantiation
struct Instantiation: Codable {
    let begin: String?
    let beginCaptures: VarGlobalBeginCaptures?
    let end: String?
    let patterns: [EndCapturePattern]?
}

// MARK: - ClassName
struct ClassName: Codable {
    let patterns: [ClassNamePattern]?
}

// MARK: - ClassNamePattern
struct ClassNamePattern: Codable {
    let begin, end: String?
    let endCaptures: VarGlobalBeginCaptures?
    let patterns: [StringDoubleQuotedPattern]?
    let include: String?
}

// MARK: - Comments
struct Comments: Codable {
    let patterns: [CommentsPattern]?
}

// MARK: - CommentsPattern
struct CommentsPattern: Codable {
    let begin: String?
    let beginCaptures: [String: The1]?
    let end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let name: String?
    let patterns: [FluffyPattern]?
    let captures: StringDoubleQuotedBeginCaptures?
}

// MARK: - FluffyPattern
struct FluffyPattern: Codable {
    let include, begin: String?
    let beginCaptures: StringDoubleQuotedBeginCaptures?
    let end, name: String?
    let patterns: [StringDoubleQuotedPattern]?
    let endCaptures: StringDoubleQuotedBeginCaptures?
}

// MARK: - FunctionCall
struct FunctionCall: Codable {
    let patterns: [FunctionCallPattern]?
}

// MARK: - FunctionCallPattern
struct FunctionCallPattern: Codable {
    let begin: String?
    let beginCaptures: [String: EndCaptureValue]?
    let end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let name: String?
    let patterns: [StringDoubleQuotedPattern]?
    let match: String?
}

// MARK: - FunctionParameters
struct FunctionParameters: Codable {
    let patterns: [FunctionParametersPattern]?
}

// MARK: - FunctionParametersPattern
struct FunctionParametersPattern: Codable {
    let include, match, name: String?
    let captures: [String: PHPDocTypesArraySingleCapture]?
    let begin: String?
    let beginCaptures: [String: PHPDocTypesArraySingleCapture]?
    let end: String?
    let patterns: [FluffyPattern]?
}

// MARK: - DocInterior
struct DocInterior: Codable {
    let patterns: [HeredocInteriorPattern]?
}

// MARK: - HeredocInteriorPattern
struct HeredocInteriorPattern: Codable {
    let begin: String?
    let beginCaptures: [String: The1]?
    let contentName: String??
    let end: End?
    let endCaptures: [String: The1]?
    let name: String??
    let patterns: [UseInnerPattern]?
}

enum End: String, Codable {
    case s2AZaZ09_X7FX10Ffff = "^\\s*(\\2)(?![A-Za-z0-9_\\x{7f}-\\x{10ffff}])"
    case s3AZaZ09_X7FX10Ffff = "^\\s*(\\3)(?![A-Za-z0-9_\\x{7f}-\\x{10ffff}])"
}

// MARK: - UseInnerPattern
struct UseInnerPattern: Codable {
    let include, match, name: String?
    let captures: [String: The1]?
    let begin, end: String?
    let patterns: [NullCoalescing]?
    let beginCaptures: VarGlobalBeginCaptures?
    let endCaptures: StringDoubleQuotedBeginCaptures?
}

// MARK: - Interpolation
struct Interpolation: Codable {
    let patterns: [StringDoubleQuoted]?
}

// MARK: - InterpolationDoubleQuoted
struct InterpolationDoubleQuoted: Codable {
    let patterns: [EndCapturePattern]?
}

// MARK: - InvokeCall
struct InvokeCall: Codable {
    let captures: [String: The1]?
    let match, name: String?
}

// MARK: - MatchStatement
struct MatchStatement: Codable {
    let patterns: [MatchStatementPattern]?
}

// MARK: - MatchStatementPattern
struct MatchStatementPattern: Codable {
    let match, begin: String?
    let beginCaptures: StringDoubleQuotedBeginCaptures?
    let end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let name: String?
    let patterns: [StringBacktick]?
}

// MARK: - StringBacktick
struct StringBacktick: Codable {
    let begin: String?
    let beginCaptures: StringDoubleQuotedBeginCaptures?
    let end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let patterns: [EndCapturePattern]?
    let name: String?
}

// MARK: - Namespace
struct Namespace: Codable {
    let begin: String?
    let beginCaptures: [String: The1]?
    let end, name: String?
    let patterns: [NullCoalescing]?
}

// MARK: - Numbers
struct Numbers: Codable {
    let patterns: [InvokeCall]?
}

// MARK: - Object
struct Object: Codable {
    let patterns: [ObjectPattern]?
}

// MARK: - ObjectPattern
struct ObjectPattern: Codable {
    let begin: String?
    let beginCaptures: [String: The1]?
    let end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let patterns: [StringDoubleQuotedPattern]?
    let name: String?
    let captures: [String: The1]?
    let match: String?
}

// MARK: - ParameterDefaultTypes
struct ParameterDefaultTypes: Codable {
    let patterns: [ParameterDefaultTypesPattern]?
}

// MARK: - ParameterDefaultTypesPattern
struct ParameterDefaultTypesPattern: Codable {
    let include, match, name, begin: String?
    let beginCaptures: [String: EndCaptureValue]?
    let end: String?
    let endCaptures: [String: EndCaptureValue]?
    let patterns: [StringDoubleQuotedPattern]?
    let captures: [String: The1]?
}

// MARK: - PHPDoc
struct PHPDoc: Codable {
    let patterns: [PHPDocPattern]?
}

// MARK: - PHPDocPattern
struct PHPDocPattern: Codable {
    let match, name: String?
    let captures: [String: The1]?
    let begin: String?
    let beginCaptures: VarGlobalBeginCaptures?
    let end, contentName: String?
    let patterns: [StringDoubleQuotedPattern]?
}

// MARK: - PHPDocTypes
struct PHPDocTypes: Codable {
    let match: String?
    let captures: PHPDocTypesCaptures?
}

// MARK: - PHPDocTypesCaptures
struct PHPDocTypesCaptures: Codable {
    let the0: InterpolationDoubleQuoted?

    enum CodingKeys: String, CodingKey {
        case the0 = "0"
    }
}

// MARK: - PHPDocTypesArrayMultiple
struct PHPDocTypesArrayMultiple: Codable {
    let begin: String?
    let beginCaptures: StringDoubleQuotedBeginCaptures?
    let end: String?
    let endCaptures: [String: The1]?
    let patterns: [EndCapturePattern]?
}

// MARK: - PHPDocTypesArraySingle
struct PHPDocTypesArraySingle: Codable {
    let match: String?
    let captures: [String: PHPDocTypesArraySingleCapture]?
}

// MARK: - RegexLEQuoted
struct RegexLEQuoted: Codable {
    let begin: String?
    let beginCaptures: StringDoubleQuotedBeginCaptures?
    let end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let name: String?
    let patterns: [ParameterDefaultTypesPattern]?
}

// MARK: - ScopeResolution
struct ScopeResolution: Codable {
    let patterns: [ScopeResolutionPattern]?
}

// MARK: - ScopeResolutionPattern
struct ScopeResolutionPattern: Codable {
    let match: String?
    let captures: [String: EndCaptureValue]?
    let begin: String?
    let beginCaptures: [String: The1]?
    let end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let name: String?
    let patterns: [StringDoubleQuotedPattern]?
}

// MARK: - SQLStringDoubleQuoted
struct SQLStringDoubleQuoted: Codable {
    let begin: String?
    let beginCaptures: StringDoubleQuotedBeginCaptures?
    let contentName, end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let name: String?
    let patterns: [ParameterDefaultTypesPattern]?
}

// MARK: - SQLStringSingleQuoted
struct SQLStringSingleQuoted: Codable {
    let begin: String?
    let beginCaptures: StringDoubleQuotedBeginCaptures?
    let contentName, end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let name: String?
    let patterns: [VarGlobal]?
}

// MARK: - StringSingleQuoted
struct StringSingleQuoted: Codable {
    let begin: String?
    let beginCaptures: StringDoubleQuotedBeginCaptures?
    let end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let name: String?
    let patterns: [NullCoalescing]?
}

// MARK: - Strings
struct Strings: Codable {
    let patterns: [StringDoubleQuotedPattern]?
}

// MARK: - Support
struct Support: Codable {
    let patterns: [NullCoalescing]?
}

// MARK: - SwitchStatement
struct SwitchStatement: Codable {
    let patterns: [SwitchStatementPattern]?
}

// MARK: - SwitchStatementPattern
struct SwitchStatementPattern: Codable {
    let match, begin: String?
    let beginCaptures: StringDoubleQuotedBeginCaptures?
    let end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let name: String?
    let patterns: [FluffyPattern]?
}

// MARK: - TernaryExpression
struct TernaryExpression: Codable {
    let begin: String?
    let beginCaptures: StringDoubleQuotedBeginCaptures?
    let end: String?
    let endCaptures: StringDoubleQuotedBeginCaptures?
    let patterns: [TernaryExpressionPattern]?
}

// MARK: - TernaryExpressionPattern
struct TernaryExpressionPattern: Codable {
    let match: String?
    let captures: PurpleCaptures?
    let include: String?
}

// MARK: - PurpleCaptures
struct PurpleCaptures: Codable {
    let the1: Strings?

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
    }
}

// MARK: - UseInner
struct UseInner: Codable {
    let patterns: [UseInnerPattern]?
}

// MARK: - VariableName
struct VariableName: Codable {
    let patterns: [VariableNamePattern]?
}

// MARK: - VariableNamePattern
struct VariableNamePattern: Codable {
    let include: String?
    let captures: [String: The1]?
    let match: String?
}
