export declare class NullishCommandResultError extends Error {
    command: string;
    constructor(command: string);
}
export declare class CommandSyntaxError extends Error {
    command: string;
    constructor(command: string);
}
export declare class InvalidCommandError extends Error {
    command: string;
    constructor(msg: string, command: string);
}
export declare class CommandExecutionError extends Error {
    command: string;
    err: Error;
    constructor(err: Error, command: string);
}
export declare class ImageError extends CommandExecutionError {
}
export declare class InternalError extends Error {
    message: string;
}
export declare class TemplateParseError extends Error {
}
