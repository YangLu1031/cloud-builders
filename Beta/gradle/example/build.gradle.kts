tasks.register("hello") {
    doLast {
        println("Hello world!")
		println("I am a Kotlin build script.")
    }
}
