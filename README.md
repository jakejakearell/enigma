Additionally, our algorithm will use the standard lowercase alphabet, plus a space, so 27 characters in total. You can use the following code snippet to create the character set:

("a".."z").to_a << " "
## Finding the Shifts
Each shift will be the sum of two other shifts known as the Keys and the Offsets. So the A shift will be the A key plus the A offset, the B shift will be the B key plus the B offset, etc.

## The Keys
The keys are created by generating a random five digit number, like 02715, and splitting it up like so:

A key: first two digits (02)
B key: second and third digits (27)
C key: third and fourth digits (71)
D key: fourth and fifth digits (15)
The Offsets
The offsets are found using the date of transmission.

Consider the date formatted as a number, DDMMYY. If the date is August 4, 1995, it would be represented as 040895.
Square the numeric form (1672401025)
Take the last four digits (1025)
A offset: The first digit (1)
B offset: The second digit (0)
C offset: The third digit (2)
D offset: The fourth digit (5)

## Encrypting a Message
Let’s say we are trying to encrypt the message "hello world".

Using the previous examples, the keys are 02, 27, 71, 15 and the offsets are 1, 0, 2, 5. So the final shifts would be:

A: 3
B: 27
C: 73
D: 20
Our character set is the alphabet and a space like this:

["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
If we are trying to encrypt “hello world”, the first character (“h”) is shifted by the A shift (3). So “h” becomes “k”.

The second character (“e”) is shifted by the B shift (27). Since there are 27 characters in our set, shifting by 27 gets us back to where we started, so “e” becomes “e”.

The third character (“l”) is shifted by the C shift (73). “l” becomes “d”.

The fourth character (“l”) is shifted by the D shift (20). “l” becomes “e”.

When we get to the 5th character (“o”), we cycle back through the shifts, so “o” is shifted by the A shift (3) and becomes “r”. The sixth character (“ “) is shifted by the B shift (27) and becomes “ “.

The final translation for this example would be:

“hello world” => “keder ohulw”

## Other notes on Encryption
You should be able to generate random numbers with leading zeros. In the example shown, the random number was 2715, so it should be zero padded to make it a five digit number (02715)
Your translation should only translate using lowercase letters. If a letter is uppercase, it should use the lowercase translation, so in the example above, “HELLO WORLD” would still translate to “keder ohulw”
If you encounter a character not in the character set, it should be translated as itself. Using the example above, “hello world!” should be translated as “keder ohulw!”
## Decrypting a Message
In order to decrypt a message, we need to know the key and date that were used for encryption. We can find the total shifts using the same methods as above. Then each character is shifted backwards instead of forwards.

## Cracking a Key
When the key is not known, we can crack the encryption using just the date of transmission. We believe that each enemy message ends with the characters " end". Use this to crack the encryption.


Class Requirements
You are required to build an Enigma class with the methods described below; you may find it useful to create additional classes and/or modules. All classes, modules and methods should have a single responsibility, and should be well organized and readable.

## Enigma Class
Create an Enigma class with the following methods:

## Enigma#encrypt(message, key, date)
+ The encrypt method takes a message String as an argument. It can optionally take a Key and Date as arguments to use for encryption. If the key is not included, generate a random key. If the date is not included, use today’s date.

The encrypt method returns a hash with three keys:

``:encryption => the encrypted String
:key => the key used for encryption as a String
:date => the date used for encryption as a String in the form DDMMYY``

## Enigma#decrypt(ciphertext, key, date)
The decrypt method takes a ciphertext String and the Key used for encryption as arguments. The decrypt method can optionally take a date as the third argument. If no date is given, this method should use today’s date for decryption.

The decrypt method returns a hash with three keys:

``:decryption => the decrypted String
:key => the key used for decryption as a String
:date => the date used for decryption as a String in the form DDMMYY``

## Interaction Pattern
The Enigma class should respond to the following interaction pattern:

``pry(main)> require 'date'
#=> true

pry(main)> require './lib/enigma'
#=> true

pry(main)> enigma = Enigma.new
#=> #<Enigma:0x00007ff90f24cb78...>

# encrypt a message with a key and date
pry(main)> enigma.encrypt("hello world", "02715", "040895")
#=>
#   {
#     encryption: "keder ohulw",
#     key: "02715",
#     date: "040895"
#   }

# decrypt a message with a key and date
pry(main) > enigma.decrypt("keder ohulw", "02715", "040895")
#=>
#   {
#     decryption: "hello world",
#     key: "02715",
#     date: "040895"
#   }

# encrypt a message with a key (uses today's date)
pry(main)> encrypted = enigma.encrypt("hello world", "02715")
#=> # encryption hash here

#decrypt a message with a key (uses today's date)
pry(main) > enigma.decrypt(encrypted[:encryption], "02715")
#=> # decryption hash here

# encrypt a message (generates random key and uses today's date)
pry(main)> enigma.encrypt("hello world")
#=> # encryption hash here``

## Command Line Interface
+ Add a command line interface for encryption and decryption. You should create a Runner file called encrypt.rb that takes two command line arguments. The first is an existing file that contains a message to encrypt. The second is a file where your program should write the encrypted message. In addition to writing the encrypted message to the file, your program should output to the screen the file it wrote to, the key and the date.

Additionally, you should create a Runner file called decrypt.rb that takes four command line arguments. The first is an existing file that contains an encrypted message. The second is a file where your program should write the decrypted message. The third is the key to be used for decryption. The fourth is the date to be used for decryption. In addition to writing the decrypted message to the file, your program should output to the screen the file it wrote to, the key used for decryption, and the date used for decryption.

You should be able to use your CLI like this:

``$ ruby ./lib/encrypt.rb message.txt encrypted.txt
Created 'encrypted.txt' with the key 82648 and date 240818
$ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 240818
Created 'decrypted.txt' with the key 82648 and date 240818``


You do not have to test your command line interface

Useful Methods
Array#rotate
Date#strftime
Date::today
Enumerator#with_index
Cracking

# The following is only required for scoring a 4 on functionality

## Enigma#crack(ciphertext, date)
The crack method decrypts a message without being given the key. This method can optionally take a date to use for cracking as a second argument. If no date is given, it should use today’s date for cracking. It should output a hash containing the decrypted message, the date used for encryption in the form of DDMMYY, and the Key used for encryption.

We believe that each enemy message ends with the characters " end". Use this to crack the encryption.

The Enigma class should now respond to the following interaction pattern:

``pry(main)> require 'date'
#=> true

pry(main)> require './lib/enigma'
#=> true

pry(main)> enigma = Enigma.new
#=> #<Enigma:0x00007ff90f24cb78...>

pry(main)> enigma.encrypt("hello world end", "08304", "291018")
#=>
#   {
#     encryption: "vjqtbeaweqihssi",
#     key: "08304",
#     date: "291018"
#   }

# crack an encryption with a date
pry(main)> enigma.crack("vjqtbeaweqihssi", "291018")
#=>
#   {
#     decryption: "hello world end",
#     date: "291018",
#     key: "08304"
#   }

# crack an encryption (uses today's date)
pry(main)> enigma.crack("vjqtbeaweqihssi")
#=>
#   {
#     decryption: "hello world end",
#     date: # todays date in the format DDMMYY,
#     key: # key used for encryption
#   }
``
## Cracking Interface
Additionally, create a Runner file called crack.rb that takes three command line arguments. The first is an existing file that contains an encrypted message. The second is a file where your program should write the cracked message. The third is the date to be used for cracking. In addition to writing the cracked message to the file, your program should output to the screen the file it wrote to, the key used for cracking, and the date used for cracking:

``$ ruby ./lib/encrypt.rb message.txt encrypted.txt
Created 'encrypted.txt' with the key 82648 and date 240818
$ ruby ./lib/crack.rb encrypted.txt cracked.txt 240818
Created 'cracked.txt' with the cracked key 82648 and date 240818``
