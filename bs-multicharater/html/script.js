window.addEventListener('message', function(event) {
    if (event.data.type === "openMenu") {
        document.getElementById('characters').innerHTML = '';
        event.data.characters.forEach(character => {
            let charDiv = document.createElement('div');
            charDiv.classList.add('character');
            charDiv.innerText = character.name;
            charDiv.onclick = () => {
                fetch(`https://${GetParentResourceName()}/selectCharacter`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ character: character })
                }).then(resp => resp.json()).then(resp => {
                    console.log(resp);
                });
            };
            document.getElementById('characters').appendChild(charDiv);
        });
        document.getElementById('character-menu').style.display = 'block';
    }
});
