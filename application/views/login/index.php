<!DOCTYPE html>
<html>

<head>
    <title>Apotek Ajwa</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="shortcut icon" type="" href="<?= base_url('assets/'); ?>dist/img/logoSIA.png">
    <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog==" crossorigin="anonymous" /> -->
    <!-- <link rel="stylesheet" href="style.css"> -->

    <link href="<?= base_url(); ?>assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <!-- Custom styles for this template-->
    <link rel="stylesheet" href="<?= base_url(); ?>assets/css/bootstrap.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #fbf3ff;
        }

        .container {
            position: absolute;
            max-width: 800px;
            height: 500px;
            margin: auto;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .myRightCtn {
            position: relative;
            background-image: linear-gradient(45deg, #6affa1, #006837);
            border-radius: 25px;
            height: 100%;
            padding: 25px;
            color: rgb(192, 192, 192);
            font-size: 12px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .myLeftCtn {
            position: relative;
            background: #fff;
            border-radius: 25px;
            height: 100%;
            padding: 25px;
            padding-left: 50px;
        }

        .myLeftCtn header {
            color: #006837;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .row {
            height: 100%;
        }

        .myCard {
            position: relative;
            background: #fff;
            height: 100%;
            border-radius: 25px;
            -webkit-box-shadow: 0px 10px 40px -10px rgba(0, 0, 0, 0.7);
            -moz-box-shadow: 0px 10px 40px -10px rgba(0, 0, 0, 0.7);
            box-shadow: 0px 10px 40px -10px rgba(0, 0, 0, 0.7);
        }

        .myRightCtn header {
            color: #fff;
            font-size: 44px;
        }

        .box {
            position: relative;
            margin: 20px;
            margin-bottom: 100px;
        }

        .myLeftCtn .myInput {
            width: 230px;
            border-radius: 25px;
            padding: 10px;
            padding-left: 50px;
            border: none;
            -webkit-box-shadow: 0px 10px 49px -14px rgba(0, 0, 0, 0.7);
            -moz-box-shadow: 0px 10px 49px -14px rgba(0, 0, 0, 0.7);
            box-shadow: 0px 10px 49px -14px rgba(0, 0, 0, 0.7);
        }

        .myLeftCtn .myInput:focus {
            outline: none;
        }

        .myForm {
            position: relative;
            margin-top: 50px;
        }

        .myLeftCtn .butt {
            background: linear-gradient(45deg, #6affa1, #006837);
            color: #fff;
            width: 230px;
            border: none;
            border-radius: 25px;
            padding: 10px;
            -webkit-box-shadow: 0px 10px 41px -11px rgba(0, 0, 0, 0.7);
            -moz-box-shadow: 0px 10px 41px -11px rgba(0, 0, 0, 0.7);
            box-shadow: 0px 10px 41px -11px rgba(0, 0, 0, 0.7);
        }

        .myLeftCtn .butt:hover {
            background: linear-gradient(45deg, #006837, #006837);
        }

        .myLeftCtn .butt:focus {
            outline: none;
        }

        .myLeftCtn .fas {
            position: relative;
            color: #6affa1;
            left: 36px;
        }

        .butt_out {
            background: transparent;
            color: #fff;
            width: 120px;
            border: 2px solid#fff;
            border-radius: 25px;
            padding: 10px;
            -webkit-box-shadow: 0px 10px 49px -14px rgba(0, 0, 0, 0.7);
            -moz-box-shadow: 0px 10px 49px -14px rgba(0, 0, 0, 0.7);
            box-shadow: 0px 10px 49px -14px rgba(0, 0, 0, 0.7);
        }

        .butt_out:hover {
            border: 2px solid#eecbff;
        }

        .butt_out:focus {
            outline: none;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="myCard">
            <div class="row">
                <div class="col-md-6">
                    <div class="myLeftCtn">
                        <form method="POST" action="<?= base_url('login/login'); ?>" class="myForm text-center">
                            <header>SIGN IN</header>
                            <?php if ($this->session->flashdata('msg')) : ?>
                                <div class="alert alert-danger"><?= $this->session->flashdata('msg') ?></div>
                            <?php endif; ?>
                            <!-- <div class="alert alert-danger">teeees</div> -->
                            <div class="form-group">
                                <i class="fas fa-user"></i>
                                <input class="myInput" type="text" placeholder="Username" name="username" id="username" required>
                            </div>
                            <div class="form-group">
                                <i class="fas fa-lock"></i>
                                <input class="myInput" type="password" name="password" id="password" placeholder="Password" required>
                            </div>
                            <button type="submit" class="butt">LOGIN</button>
                        </form>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="myRightCtn">
                        <div class="box">
                            <img src="<?= base_url('assets/'); ?>dist/img/logo TULISAN 2.png" class="img-fluid" alt="">
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script> -->

    <script src="<?= base_url(); ?>assets/vendor/jquery/jquery.min.js"></script>
    <script src="<?= base_url(); ?>assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>

</html>