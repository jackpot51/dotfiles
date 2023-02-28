class ExCommandModeInputElement extends HTMLDivElement
  createdCallback: ->
    @className = "command-mode-input"

    @editorContainer = document.createElement("div")
    @editorContainer.className = "editor-container"

    @appendChild(@editorContainer)

  initialize: (@viewModel, opts = {}) ->
    if opts.class?
      @editorContainer.classList.add(opts.class)

    if opts.hidden
      @editorContainer.style.height = "0px"

    @editorElement = document.createElement "atom-text-editor"
    @editorElement.classList.add('editor') # Consider this deprecated!
    @editorElement.classList.add('ex-mode-editor')
    @editorElement.getModel().setMini(true)
    @editorElement.setAttribute('mini', '')
    @editorContainer.appendChild(@editorElement)

    @singleChar = opts.singleChar
    @defaultText = opts.defaultText ? ''

    @panel = atom.workspace.addBottomPanel(item: this, priority: 100)

    @focus()
    @handleEvents()

    this

  handleEvents: ->
    if @singleChar?
      @editorElement.getModel().getBuffer().onDidChange (e) =>
        @confirm() if e.newText
    else
      atom.commands.add(@editorElement, 'editor:newline', @confirm.bind(this))
      atom.commands.add(@editorElement, 'core:backspace', @backspace.bind(this))

    atom.commands.add(@editorElement, 'core:confirm', @confirm.bind(this))
    atom.commands.add(@editorElement, 'core:cancel', @cancel.bind(this))
    atom.commands.add(@editorElement, 'ex-mode:close', @cancel.bind(this))
    atom.commands.add(@editorElement, 'blur', @cancel.bind(this))

  backspace: ->
    # pressing backspace over empty `:` should cancel ex-mode
    @cancel() unless @editorElement.getModel().getText().length

  confirm: ->
    @value = @editorElement.getModel().getText() or @defaultText
    @viewModel.confirm(this)
    @removePanel()

  focus: ->
    @editorElement.focus()

  cancel: (e) ->
    @viewModel.cancel(this)
    @removePanel()

  removePanel: ->
    atom.workspace.getActivePane().activate()
    @panel.destroy()

module.exports =
document.registerElement("ex-command-mode-input"
  extends: "div",
  prototype: ExCommandModeInputElement.prototype
)
