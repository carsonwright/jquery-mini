gulp = require("gulp")
coffeex = require('gulp-coffee-react')
gutil = require("gulp-util")
coffee = require('gulp-coffee')
server = require('gulp-server-livereload')
mocha = require('gulp-mocha')
fs = require("fs")
gulp.task('webserver', ->
  gulp.src('public').pipe(server({livereload: true, directoryListing: false, open: true}))
)

gulp.task('react', ->
  gulp.src('./src/*.jsx').pipe(coffeex({bare: true}).on('error', gutil.log)).pipe(gulp.dest('./public/'))
)

gulp.task('coffee', ->
  gulp.src('./src/*.coffee').pipe(coffee({bare: true}).on('error', gutil.log)).pipe(gulp.dest('./public/'))
)
 
gulp.task('test', ->
  gulp.src('./tests/src/*.coffee').pipe(coffee({bare: true}).on('error', gutil.log)).pipe(gulp.dest('./tests/js/'))

  gulp.src('./tests/*.coffee', {read: false}).pipe(mocha())
)

gulp.task("default", ["react", 'coffee', "webserver"])
