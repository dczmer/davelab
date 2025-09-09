---
title: About davelab
---
# About davelab

I frequently observe other engineers struggling to work from the command line. Often, they have no idea how much they are actually struggling because they've never seen a more efficient setup, or they think that learning to use the shell is unapproachable because it's too difficult and strange.

> Using the shell is becoming a lost art. It's still the fastest and most efficient way to work with your operating system.
<cite>- Me</cite>

The first inspiration I had was when I overheard some other people complaining that ZSH doesn't share command history across multiple terminals. So I showed them the `SHARE_HISTORY` option, and some other related options, to enable the shared history functionality that they wanted.

So the first idea was just to write a document that outlined my configuration file, line-by-line, while giving just a bit of context and some useful links on each topic. I would share that with junior engineers, or anyone who wanted a guide for configuring their shell.

My configuration file is only about 75 lines long, but explaining what each line does requires a surprising amount of context first. And things that you may want to customize may require learning another mini-language. The document stated getting longer, and I needed to break it up into multiple files, to make each file more approachable than one very long document.

As I started breaking the document into files based on topics, I decided to just use the GitHub repository view as the interface for reading this content. It renders Markdown and shows inline images, you can link between Markdown files in the same repository, and you don't need to find separate hosting.

The next source of inspiration came when I shared a command for someone to run, a simple `find` with `-exec` command, instead of making a one-off Python script. But, since they didn't understand what the command did, they didn't want to run it. And even when I convinced them it was safe, they didn't have `coreutils` (required for the `find` command) on their MacBook system anyway.

So now I want to make this a course on command line productivity instead of just a walk-through of my own ZSH configuration. That requires covering everything from configuring your system, piping, scripting, globbing and expansion. But the important, overarching lesson, is the value of streams and "lines of text" that can be processed like batches of tabular data. This, combined with piping, is what makes it possible to transform the output of a command to do things like reporting, configuring, or even generating other complex commands to execute.

A little later, I heard about GitHub Pages. With the push of a button, it would create a free hosted site and publish all of the Markdown files from the project as a Jekyll static site. Just... I didn't really like the default layout for what I wanted.

So I found out you can create a Jekyll project and build it the way you want, then use GitHub Pages (via GitHub Actions) to publish the compiled static site on every commit. I think I could have used any static site generator, but Jekyll seemed like the least friction (except learning a new HTML templating language and working with Ruby).

Since I was able to customize everything myself, I wanted some specific features:

1. Layout should support mobile and "1/2 screen" view (for working with browser and terminal side-by-side). When the page gets too narrow, the navigation menu should pop-up into a horizontal bar on the header.
2. There is no need for JavaScript here, even where it might be a little convenient in some places. So this site is strictly no-script.
3. I wanted to use a "programming" mono-space font, one that has support for extra glyphs and symbols.
4. I wanted to chase LightHouse scores for a bit as a way to learn more about web performance.

<!--
Another recent bout of inspiration came when another engineer I know mentioned they were having trouble prototyping something on their work-issued MacBook. They wanted to tutorial and demo something for a proposal, but they needed a specific version of python and certain dependencies. Besides the issue of running the right Python version, they also had an issue where the packages they installed with `pip` were not available when they tried to run their app.

So I wanted to write something about prototyping and "personal projects" - managing various prototypes, examples, and tutorials. This requires talking about dependencies, dependency management systems and techniques, as well as isolation (dependency isolation and system isolation).

I enjoy programming and learning about computers and technology. My job (currently) involves computers and technology. This means that my hobby activities directly benefit my performance at work. I can't make other people change what hobbies they find rewarding, but I can say that having a genuine interest in the technology you work with will be beneficial.

You can learn a lot by doing tutorial after tutorial, but to really learn something you need to do a more involved project. This is where you will learn the idiosyncrasies of whatever you are working with, and you will start to develop patterns and opinions that you will use to inform future decisions and conversations. Having "personal" or "pet" projects, or regularly contributing to an open-source project, are the best way to actually learn something.

And the most recent inspiration was another observation: watching other engineers with very slow development cycles. I'm talking about how much time and effort is required between when you make a change to your code, and when you observe the effects of that change. Debugging your web server, running tests, etc. You should optimize these tasks to be as quick and easy as possible because you do them so frequently throughout the day.

> So the theme of this site is actually "developer productivity" but from my command-line-centric point-of-view.

-->
