// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

using System.CommandLine;
using System.Threading.Tasks;

namespace PSRule.Rules.Azure.BuildTool
{
    class Program
    {
        /// <summary>
        /// Entry point for build tool.
        /// </summary>
        static async Task Main(string[] args)
        {
            await Build().InvokeAsync(args);
        }

        private static Command Build()
        {
            var builder = ClientBuilder.New();
            builder.AddProviderResource();
            return builder.Command;
        }
    }
}
