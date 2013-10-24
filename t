
[1mFrom:[0m /home/michael/projects/padrinoblog/db/seeds.rb @ line 41 :

    [1;34m36[0m:   [1;32m:post_date[0m => [1;34m[4mDate[0m.today, [1;32m:author[0m => dan, [1;32m:published[0m => [1;36mtrue[0m)
    [1;34m37[0m: }
    [1;34m38[0m: 
    [1;34m39[0m: post = [1;34m[4mPost[0m.new([1;32m:title[0m =>  [32m[1;32m"[0m[32mWith comments[1;32m"[0m[32m[0m, [1;32m:content[0m => [1;34m[4mFaker[0m::[1;34m[4mLorem[0m.words([1;34m50[0m).join([32m[1;32m"[0m[32m [1;32m"[0m[32m[0m), 
    [1;34m40[0m:   [1;32m:post_date[0m => [1;34m[4mDate[0m.today, [1;32m:author[0m => dan, [1;32m:published[0m => [1;36mtrue[0m)
 => [1;34m41[0m: binding.pry
    [1;34m42[0m: [1;34m3[0m.times {
    [1;34m43[0m:   post.comments << [1;34m[4mComment[0m.create([1;32m:content[0m => [32m[1;32m'[0m[32mNice[1;32m'[0m[32m[0m, [1;32m:comment_date[0m => [1;34m[4mDate[0m.today)
    [1;34m44[0m: }
    [1;34m45[0m: 
    [1;34m46[0m: post.tags << padrino

