function c = benchmarkPaths(setPath)
	c.rootDir = fullfile('/home/micah/courses/Computer_Vision/project');
		c.benchmarkDataDir = fullfile(c.rootDir, 'data', 'benchmarkData');
			c.benchmarkGtDir = fullfile(c.benchmarkDataDir, 'groundTruth');
			c.sceneClassFile = fullfile(c.benchmarkDataDir, 'sceneClassification', 'imgAllScene');

	c.benchmarkCache = fullfile('/home/micah/courses/Computer_Vision/project', 'benchmarkCache');
		c.amodalTmpDir = fullfile(c.benchmarkCache, 'amodal', 'benchmarks');
		c.contoursTmpDir = fullfile(c.benchmarkCache, 'contours', 'benchmarks');

	c.floorId = 2;
end
