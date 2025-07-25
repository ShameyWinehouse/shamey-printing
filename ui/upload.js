import * as jose from 'jose';

$(document).ready(function () {

    console.log("foo2")

    const createJwt = async () => {


        const algorithm = 'RS256'
        const pkcs8 = `-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDDYqxVOUlas1tO\n2MH0SYUOimk+oEuxJCOQV0i8dsQr+x2XCoWMkP2AXL5SdMD1jZgQTv32MtSjN79i\noGV/iEi8zC2XwyUs9uWHqSjZ+86cHzjt97Uo/1A52Fyf2cLWNYyeURsrO9jdREdV\n764sMhVFrZ1YtDrwz1V8YjCNvGm8KBkmgWwaKNRBa76Ce4gM49WTjcyKqSJQ2Jd4\ncAyupwtMQoHKKSWdFKI5Mx0J1g6efuMRdJWqs/XVIazz0Q4JdwXGrzyvIDA0Otxz\n0LM7c4xfcwm4NdlTx6wvvXBy9HxRi79cFIF4QLvXLHeiOFkf2l23w1gBuSBmF4ka\nZqhQxxH/AgMBAAECggEAQCi4P1oK6PJJkvghpIa53x77VVnM0TP1S7Ily+FSJMEW\no+EMHq8D13Fc+/Wj4V5oJz7RLVXetmQZgBj8i2bkv75qYFHv9LZ0g9o79Gy4GVM1\nXgs/3WENZplSPRmEXdQCw4ANpGJIIcyIgkMs1g1yJ8nNh/HTAv2KbEhP+lL7A5Iy\nSBcrGZn7Ih566wMZ8ZZXt6MPYCwZwNmcLOXrbSaLu+NmfJtrQ4pwe4Q75+Dzi0Dm\nkKwU9lq5eAxniKrxK8JlX1rBTgcp8bZfIUnaGjlvp9HYjmyJ20FgQptDt6smitv6\nJBlF1dE95seDJMHJ25FN1RJYhVzSCyA5oZtO/6PqjQKBgQDoJuF1ne/kqH5AhJZg\nEM5HSkWiuJfty5User35KrZ2BSpq9RrYeLGjmu5GaYt0Z0C+GH44zO4XYt8H1Jqh\nqMTavTfIZ9zAfKJc7GDsibDIK1la3SCab0exWwNyVKImW3wm0qX168xrGGR82zC4\nYXji8we+gSnD8Hj+597O6v90HQKBgQDXdOkTu8AFHAQoqhumjtZVNI5vybX3bl2q\nVEbf9v6joW2OC1SweJ4FPRpP+mWHcq+W3EY3b/xjg3sTsOSMMLC6KATfohM3v+s7\n8rMkdfeJcSYRX0o5ufPRvl/U78H60RPA3LVOnLiBKQQjAVratnrraOP0Vzl82hYt\nV5GE5D/LywKBgDbT5++VS3DfcmHebn1lurIPkn6pxgf9Ss/kdTWBpvIcqjX0iVCS\nwLF5B8lNaAgn0pySwEy96YVQbog06AhCCav3gFMuZG55gQcdNI7ovf2ob0QMcYTH\nv1Ddw+SepGUWui2ZFmUMOY0Zh7INOmZxbtF6wFt3udty0cCyFmccDRTpAoGBAM33\nKyD8KHI5+BfPliNBBM/rMAbZcySX0t6TNjW/7mkKVqqlVk5k39ruMIsoOYqkLgsv\ng8hXO5T+CdgnEDScDzXGL/KBA5IV25AxUOOYCgzPp66Pw2svwk9NiFsM4AkfeZyy\n4HfIBfEi/ptgHjRaoWMNoGziPUiHSxAJWEkL0ZjFAoGBAJ4MCakjk7J3f+eWVsVx\nroZBmVZJEZ2M1shNAnrIgXJ7KN4Sa/XsPavUvD1ZMf1hiaadrUEPWW8Zxbt338Cg\ntzTZMWKmi6H+pXsbV04DhAhE0K9NYazoeXafkv7svCPE0BoJiws96rLFj1New21X\nhefTAgWQn7apmGiH81fRl/xA\n-----END PRIVATE KEY-----\n`
        console.log('pkcs8', pkcs8)
        const ecPrivateKey = await jose.importPKCS8(pkcs8, algorithm)

        console.log('ecPrivateKey', ecPrivateKey)


        // Get the JWT
        // const secret = jose.base64url.decode('MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDDYqxVOUlas1tO\n2MH0SYUOimk+oEuxJCOQV0i8dsQr+x2XCoWMkP2AXL5SdMD1jZgQTv32MtSjN79i\noGV/iEi8zC2XwyUs9uWHqSjZ+86cHzjt97Uo/1A52Fyf2cLWNYyeURsrO9jdREdV\n764sMhVFrZ1YtDrwz1V8YjCNvGm8KBkmgWwaKNRBa76Ce4gM49WTjcyKqSJQ2Jd4\ncAyupwtMQoHKKSWdFKI5Mx0J1g6efuMRdJWqs/XVIazz0Q4JdwXGrzyvIDA0Otxz\n0LM7c4xfcwm4NdlTx6wvvXBy9HxRi79cFIF4QLvXLHeiOFkf2l23w1gBuSBmF4ka\nZqhQxxH/AgMBAAECggEAQCi4P1oK6PJJkvghpIa53x77VVnM0TP1S7Ily+FSJMEW\no+EMHq8D13Fc+/Wj4V5oJz7RLVXetmQZgBj8i2bkv75qYFHv9LZ0g9o79Gy4GVM1\nXgs/3WENZplSPRmEXdQCw4ANpGJIIcyIgkMs1g1yJ8nNh/HTAv2KbEhP+lL7A5Iy\nSBcrGZn7Ih566wMZ8ZZXt6MPYCwZwNmcLOXrbSaLu+NmfJtrQ4pwe4Q75+Dzi0Dm\nkKwU9lq5eAxniKrxK8JlX1rBTgcp8bZfIUnaGjlvp9HYjmyJ20FgQptDt6smitv6\nJBlF1dE95seDJMHJ25FN1RJYhVzSCyA5oZtO/6PqjQKBgQDoJuF1ne/kqH5AhJZg\nEM5HSkWiuJfty5User35KrZ2BSpq9RrYeLGjmu5GaYt0Z0C+GH44zO4XYt8H1Jqh\nqMTavTfIZ9zAfKJc7GDsibDIK1la3SCab0exWwNyVKImW3wm0qX168xrGGR82zC4\nYXji8we+gSnD8Hj+597O6v90HQKBgQDXdOkTu8AFHAQoqhumjtZVNI5vybX3bl2q\nVEbf9v6joW2OC1SweJ4FPRpP+mWHcq+W3EY3b/xjg3sTsOSMMLC6KATfohM3v+s7\n8rMkdfeJcSYRX0o5ufPRvl/U78H60RPA3LVOnLiBKQQjAVratnrraOP0Vzl82hYt\nV5GE5D/LywKBgDbT5++VS3DfcmHebn1lurIPkn6pxgf9Ss/kdTWBpvIcqjX0iVCS\nwLF5B8lNaAgn0pySwEy96YVQbog06AhCCav3gFMuZG55gQcdNI7ovf2ob0QMcYTH\nv1Ddw+SepGUWui2ZFmUMOY0Zh7INOmZxbtF6wFt3udty0cCyFmccDRTpAoGBAM33\nKyD8KHI5+BfPliNBBM/rMAbZcySX0t6TNjW/7mkKVqqlVk5k39ruMIsoOYqkLgsv\ng8hXO5T+CdgnEDScDzXGL/KBA5IV25AxUOOYCgzPp66Pw2svwk9NiFsM4AkfeZyy\n4HfIBfEi/ptgHjRaoWMNoGziPUiHSxAJWEkL0ZjFAoGBAJ4MCakjk7J3f+eWVsVx\nroZBmVZJEZ2M1shNAnrIgXJ7KN4Sa/XsPavUvD1ZMf1hiaadrUEPWW8Zxbt338Cg\ntzTZMWKmi6H+pXsbV04DhAhE0K9NYazoeXafkv7svCPE0BoJiws96rLFj1New21X\nhefTAgWQn7apmGiH81fRl/xA')
        // const jwt = await new jose.EncryptJWT()
        // // .setProtectedHeader({ alg: 'RS256', enc: 'A128CBC-HS256', typ: 'JWT', kid: 'bf6257ce40e9846a5013b3c535141e2ea0000905' })
        // // alg: 'dir' = JWE Content Encryption Algorithms ("enc") used in Direct Encryption Mode
        // // .setProtectedHeader({ alg: 'dir', enc: 'A128CBC-HS256' })
        // // HS256
        // .setProtectedHeader({ alg: 'RS256' })
        // .setIssuedAt()
        // .setIssuer('rrrp-printing-press@rrrp-printing-press.iam.gserviceaccount.com')
        // .setSubject('rrrp-printing-press@rrrp-printing-press.iam.gserviceaccount.com')
        // .setAudience('https://storage.googleapis.com')
        // .setExpirationTime('2h')
        // .encrypt(ecPrivateKey)

        


        const jwt = await new jose.SignJWT({ scope: 'https://www.googleapis.com/auth/devstorage.read_write' })
            .setProtectedHeader({ alg: algorithm, typ: 'JWT', kid: 'bf6257ce40e9846a5013b3c535141e2ea0000905' })
            .setIssuedAt()
            .setIssuer('rrrp-printing-press@rrrp-printing-press.iam.gserviceaccount.com')
            .setSubject('rrrp-printing-press@rrrp-printing-press.iam.gserviceaccount.com')
            .setAudience('https://storage.googleapis.com/')
            .setExpirationTime('2h')
            .sign(ecPrivateKey)

            
        console.log('jwt', jwt)

        return jwt;

    };

    


    


    const convertBase64 = (file) => {
        return new Promise((resolve, reject) => {
            const fileReader = new FileReader();
            fileReader.readAsDataURL(file);
    
            fileReader.onload = () => {
                resolve(fileReader.result);
            };
    
            fileReader.onerror = (error) => {
                reject(error);
            };
        });
    };


    



    var input = document.getElementById('uploadInput');
    console.log('input', input);

    input.onclick = function () {
        console.log('onclick', this.value);
        this.value = null;
    };

    // let fileHandle;
    // async function fileOpen() {
    //     [fileHandle] = await window.showOpenFilePicker();
    //     const file = await fileHandle.getFile();
    //     console.log(await file.text());
    // }

    var submit = document.getElementById('submitInput');

    submit.addEventListener('click', async () => {
        // [fileHandle] = await window.showOpenFilePicker();
        // const file = await fileHandle.getFile();
        input.click()
      });
      

    // submit.onclick = function () {
    //     console.log('onclick - submit', this.value);
    //     fileOpen()
    // };

    input.onchange = async function () {
        console.log(this.value);

        let input = this.files[0];

        // Get a JWT
        let signedJwt = await createJwt();
        
        // Convert the file to Base64-encoded
        const base64 = await convertBase64(input);


        



        let stringified = JSON.stringify({uploadedFile: base64, jwt: signedJwt})
        console.log('stringified', stringified)

        fetch(`https://${GetParentResourceName()}/` + "upload", {
            method: 'POST',
            body: stringified
        });

        // for (const file of uploadInput.files) {
            //             console.log('file', file)
            //             // console.log('bytes', file.bytes())
            //         }
            //         const base64 = await convertBase64(uploadInput.files[0]);
            //         fetch(`https://${GetParentResourceName()}/` + "upload", {
            //             method: 'POST',
            //             body: JSON.stringify({uploadedFile: base64})
            //           })
    };

    // onInputClick = (event) => {
    //     console.log('oninputclick')
    //     event.target.value = ''
    // }

    // onFileChanged = (event) => {
        
    //     console.log('event', event)


        // for (const file of uploadInput.files) {
        //     console.log('file', file)
        //     // console.log('bytes', file.bytes())
        // }
        // const base64 = await convertBase64(uploadInput.files[0]);
        // fetch(`https://${GetParentResourceName()}/` + "upload", {
        //     method: 'POST',
        //     body: JSON.stringify({uploadedFile: base64})
        //   })
    // }

    // const uploadInput = document.getElementById("uploadInput");
    // uploadInput.addEventListener(
    //     "change",
    //     async () => {
            
            
    //     }
    // )

    // const uploadInput = document.getElementById("uploadInput");
    // uploadInput.addEventListener(
    //     "change",
    //     async () => {
            
    //         for (const file of uploadInput.files) {
    //             console.log('file', file)
    //             // console.log('bytes', file.bytes())
    //         }
    //         const base64 = await convertBase64(uploadInput.files[0]);
    //         fetch(`https://${GetParentResourceName()}/` + "upload", {
    //             method: 'POST',
    //             body: JSON.stringify({uploadedFile: base64})
    //           })
    //     }
    // )
});


// $(document).ready(function () {
//   var fuel = 0;
//   var speed = 0.0;
//   var show = false;
//   window.addEventListener("message", function (event) {
//     if (event.data.showhud == undefined) {
//       fuel = event.data.fuel;
//       speed = event.data.speed;
//       setFuel(fuel, '.progress-fuel');
//       // setFuelGauge(fuel, '.gauge-fuel-needle');
//       setSpeed(speed, '.progress-speed');
//     }
//     if (event.data.showhud == true || event.data.showhud == false) {
//       show = event.data.showhud;
//     }
//     if (show == true) {
//       $('#choochoo-hud').show();
//       setFuel(fuel, '.progress-fuel');
//       // setFuelGauge(fuel, '.gauge-fuel-needle');
//       setSpeed(speed, '.progress-speed');
//     } else {
//       $('#choochoo-hud').hide();
//     }
//   });

//   // Functions
//   function setFuel(amount, element) {
//     var html = $(element);
//     html.text(amount.toFixed(0));
//   }
//   // function setFuelGauge(amount, element) {
//   //   var html = $(element);
//   //   var base = -163;
//   //   var deg = base - (amount * 10);
//   //   html.css("transform", "rotate("+deg+"deg)");
//   // }
//   function setSpeed(amount, element) {
//     var html = $(element);
//     html.text(amount.toFixed(1));
//   }


// });
