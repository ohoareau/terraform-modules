import { Node, ReportData, Context, CreateReportOptions, Images, Links, Htmls } from './types';
export declare function extractQuery(template: Node, options: CreateReportOptions): Promise<string | undefined>;
declare type ReportOutput = {
    status: 'success';
    report: Node;
    images: Images;
    links: Links;
    htmls: Htmls;
} | {
    status: 'errors';
    errors: Error[];
};
export declare function produceJsReport(data: ReportData | undefined, template: Node, options: CreateReportOptions): Promise<ReportOutput>;
export declare function walkTemplate(data: ReportData | undefined, template: Node, options: CreateReportOptions, processor: CommandProcessor): Promise<ReportOutput>;
declare type CommandProcessor = (data: ReportData | undefined, node: Node, ctx: Context) => Promise<undefined | string | Error>;
export declare function getCommand(command: string, shorthands: Context['shorthands'], fixSmartQuotes: boolean): string;
export declare function splitCommand(cmd: string): {
    cmdName: string | undefined;
    cmdRest: string;
};
export {};
