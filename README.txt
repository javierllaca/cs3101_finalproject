cs3101 - Programming in iOS
Final Project
Name: Javier Llaca
UNI: jl3960
---------------------------

Application overview:

The user of this app can:
- Write and store an arbitrary number of text-based notes
- Go back and edit note content
- Delete notes from list
- Attach pictures to notes
- Email notes

Each note contains:
- Title
- Body of text
- Date and time of creation
- Picture


View Hierarchy:

|---- HomeView
    |
    |---- TitleInputView
    |   |
    |   |---- ContentInputView
    |       |
    |       |---- ImageSelectionView
    |
    |---- NoteView