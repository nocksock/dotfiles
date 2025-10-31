function Bar(monitor = 0) {
  return (
    <window visible class="Bar" monitor={monitor}>
      <box>Content of the widget</box>
    </window>
  )
}

app.start({
  main() {
    Bar(0)
    Bar(1) // instantiate for each monitor
  },
})
