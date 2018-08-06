const gulp = require('gulp');

gulp.task('lint', function lintCssTask() {
  const gulpStylelint = require('gulp-stylelint');
  const stylelintFormatter = require('stylelint-formatter-pretty');

  return gulp
    .src("./src/scripts/modules/media/body/*.less")
    .pipe(gulpStylelint({
      failAfterError: true,
      reportOutputDir: 'reports/lint',
      reporters: [
        {formatter: stylelintFormatter, console: true},
        {formatter: 'json', save: 'report.json'},
        {formatter: stylelintFormatter, save: 'my-custom-report.txt'}
      ],
      debug: true
    }));
});
