function c = benchmarkPaths(setPath)
	c.rootDir = fullfile('/home/Documents/CV_project');
		c.benchmarkDataDir = fullfile(c.rootDir, 'data', 'benchmarkData');
			c.benchmarkGtDir = fullfile(c.benchmarkDataDir, 'groundTruth');
			c.sceneClassFile = fullfile(c.benchmarkDataDir, 'sceneClassification', 'imgAllScene');

	c.benchmarkCache = fullfile('/home/Documents/CV_project', 'benchmarkCache');
		c.amodalTmpDir = fullfile(c.benchmarkCache, 'amodal', 'benchmarks');
		c.contoursTmpDir = fullfile(c.benchmarkCache, 'contours', 'benchmarks');

	c.floorId = 2;
end
