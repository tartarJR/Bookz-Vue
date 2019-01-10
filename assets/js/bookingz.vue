<template>

<div>
  
    <h3>Book Loans</h3>

    <p> {{ this.responseMessage }} </p>

    <table class="table">

        <thead>

            <tr>

                <th>Title</th>

                <th>Start Date</th>

                <th>Due Date</th>

                <th>Number Of Extensions</th>

                <th>Action</th>

            </tr>

        </thead>

        <tbody id="books">

            <tr v-for="(book, i) in books" :key="book.id">

                <td> {{ book.title }} </td>

                <td> {{ book.start_date }} </td>

                <td> {{ book.due_date }} </td>

                <td> {{ book.num_of_extensions }} </td>

                <td>
                    <a :id="i + 1" v-if="book.should_show_action" v-on:click="extendBookLoan(book.id)">Extend Loan</a>
                    <label v-else>Loan Expired</label>
                </td>

            </tr>

        </tbody>

    </table>

    Display only ongoing book loans
    <input type="checkbox" id="all" v-model="shouldDisplayAllBooks" v-on:click="switchBookDisplay" />

</div>

</template>

<script>

    import axios from "axios";

    export default {
        
        data: function(){

            return {
            
                shouldDisplayAllBooks: true,

                books: [],

                responseMessage: ""

            }

        },

        mounted() {
        
            this.getBookLoans(false)

        },

        methods: {
        
            getBookLoans: function(shouldDisplayAllBooks) {
            
                axios.post("/api/book-loans", { should_show_all_books: shouldDisplayAllBooks })
                        .then(response => {

                        this.books = response.data.books
                        
                        }).catch(error => {
                            
                            console.log(error);

                        });

            },

            extendBookLoan: function(bookId) {

                axios.post("/api/book-loans/extend", { book_id: bookId })
                        .then(response => {

                              this.responseMessage = response.data.response_message

                          }).then(response => {

                              this.getBookLoans(false)

                          }).catch(error => {

                              console.log(error);

                          });

            },

            switchBookDisplay: function() {

                this.getBookLoans(this.shouldDisplayAllBooks)

            }
        
        }
    }

</script>
