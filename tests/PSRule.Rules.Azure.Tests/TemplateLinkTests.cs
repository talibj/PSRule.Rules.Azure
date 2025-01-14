// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

using System;
using System.IO;
using System.Management.Automation;
using PSRule.Rules.Azure.Configuration;
using PSRule.Rules.Azure.Data.Template;
using PSRule.Rules.Azure.Pipeline;
using Xunit;

namespace PSRule.Rules.Azure
{
    public sealed class TemplateLinkTests
    {
        [Fact]
        public void Pipeline()
        {
            var pipeline = NewPipeline();
            pipeline.Begin();
            pipeline.Process(PSObject.AsPSObject(GetSourcePath("Resources.Parameters.json")));
            pipeline.Process(PSObject.AsPSObject(new FileInfo(GetSourcePath("Resources.Parameters.json"))));
            pipeline.End();
        }

        [Fact]
        public void GetBicepParameters()
        {
            var helper = new TemplateLinkHelper(GetContext(), AppDomain.CurrentDomain.BaseDirectory, true);
            var link = helper.ProcessParameterFile(GetSourcePath("Tests.Bicep.1.Parameters.json"));
            Assert.NotNull(link);
            Assert.NotNull(link.TemplateFile);
            Assert.NotNull(link.ParameterFile);
        }

        #region Helper methods

        private static string GetSourcePath(string fileName)
        {
            return Path.Combine(AppDomain.CurrentDomain.BaseDirectory, fileName);
        }

        private static IPipeline NewPipeline()
        {
            var builder = PipelineBuilder.TemplateLink(AppDomain.CurrentDomain.BaseDirectory);
            return builder.Build();
        }

        private static PipelineContext GetContext()
        {
            return new PipelineContext(GetOption(), null);
        }

        private static PSRuleOption GetOption()
        {
            return PSRuleOption.Default;
        }

        #endregion Helper methods
    }
}
