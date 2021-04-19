
// Fetch my Github repository 
(function(){

    // You can use this github key if you want, you silly human... ! (read access to public data)
    const github = "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";
        
    // On DOM load, generate project card
    document.addEventListener('DOMContentLoaded', function(event) {
            
        let parent_dom_element = document.getElementById('projects-list');
        
        RetreiveGithubProjects(parent_dom_element);
    });


    
    /**
     * Fetch public project of github
     * and append generated cards to the dom
     * @param {Node} parent_dom_element parent dom element
     */
    function RetreiveGithubProjects(parent_dom_element) {
                    
        // Find repositories    
        ExecuteHttpRequest({
            method: 'GET',
            url: 'https://api.github.com/users/tonybloc/repos',
            header : {
                'Content-Type': 'application/json',
                'Authorization': `token ${github}`
            },
            data: null,
            success: function(response) {
                
                let repository = JSON.parse(response);
                console.log(repository);

                for (var index in repository) {
                    let project = repository[index];

                    // Add new card of project
                    let htmlElement = FormatProjectToHtml(
                        project['id'],
                        project['name'],
                        project['description'],
                        project['html_url'],
                        project['updated_at'],
                        project['created_at'],
                        project['language'],
                        project['has_pages'],
                    );
                    parent_dom_element.appendChild(htmlElement);
                
                    // Get Screenshot of project
                    let image_dom_identifier = `${project['id']}-image`;
                    let blobs_url = project['blobs_url'];
                    let content_url = project['contents_url'];
                    content_url = content_url.replace('{+path}', '');
                    
                    FindScreenshotOfProject(content_url, blobs_url, image_dom_identifier);
                }
                
            },
            failed: function(response) {
                console.log('error' + response);
            },
            startLoading: function() {
            },
            endLoading: function() {
            } 
        });
    }

    /**
     * Find the url of the project 'screenshot.png'
     * @param {string} content_url content url
     * @param {string} blobs_url image blob url
     * @param {string} project_id : project identifier
     * @param {string} image_dom_identifier : dom identifer
     */
    function FindScreenshotOfProject(content_url, blobs_url, image_dom_identifier) {

        ExecuteHttpRequest({
            method: 'GET',
            url: content_url,
            header : {
                'Content-Type': 'application/json',
                'Authorization': `token ${github}`
            },
            data: null,
            success: function(response) {
                
                let data = JSON.parse(response);

                // For each content 'file or directory' of the repository
                for (var index in data) {

                    let content_entry = data[index];
                    
                    // find 'screenshot.png'
                    if ( (content_entry['type'] == 'file') && (content_entry['name'] == 'screenshot.png') ) {
                        
                        // build blob url
                        blobs_url = blobs_url.replace('{/sha}', `/${content_entry['sha']}`);
                        
                        UpdateSourceOfProjectImage(blobs_url, image_dom_identifier)
                    }
                }
            },
            failed: function(response) {
            },
            startLoading: function() {
            },
            endLoading: function() {
            }
        });
    }

    /**
     * Update the image 'src' of project card
     * @param {string} blobs_url : image blob url
     * @param {string} image_dom_identifier : dom identifier
     */
    function UpdateSourceOfProjectImage(blobs_url, image_dom_identifier) {
        
        ExecuteHttpRequest({
            method: 'GET',
            url: blobs_url,
            header : {
                'Content-Type': 'application/json',
                'Authorization': `token ${github}`
            },
            data: null,
            success: function(response) {
                
                let data = JSON.parse(response);
                
                // update src of image
                let html = document.getElementById(image_dom_identifier);
                console.log(image_dom_identifier);

                html.src = `data:image/pnh;${data['encoding']}, ${data['content']}`;
                
            },
            failed: function(response) {
            },
            startLoading: function() {
            },
            endLoading: function() {
            } 

        });
    }
    
    

    /**
     * 
     * @param {object} params 
     * Formatted like
     *      method:         string
     *      url:            string
     *      header:         object
     *      data:           object
     *      success:        callback
     *      failed:         callback
     *      startLoading:   callback
     *      endLoading:     callback
     */
    function ExecuteHttpRequest(params) {
        // Find the object depending on the browser
        try {
            var httpRequest = new ActiveXObject('Microsoft.XMLHTTP');
        } catch(exception) {
            var httpRequest = new XMLHttpRequest();
        }

        // Initialize the request with method and url
        httpRequest.open(params['method'], params['url']);

        // Initialize the header of the request
        for (var key in params['header']) {
            if (params['header'].hasOwnProperty(key)) {
                httpRequest.setRequestHeader(key, params['header'][key]);
            }
        }

        // Manage callbacks
        httpRequest.onreadystatechange = function() {

            if ((this.readyState == XMLHttpRequest.LOADING)) {
                params['startLoading']();
            }

            if (this.readyState == XMLHttpRequest.DONE) {
                if (this.status == 200) {
                    params['success'](this.responseText, this.status);
                }
                else if (this.status >= 400 || this.status <= 599) {
                    params['failed'](this.responseText, this.status);
                }
                else {
                    params['success'](this.responseText, this.status);
                }
                params['endLoading']();
            }
        }

        // send request
        httpRequest.send(params['data']);
    }

    
    /**
     * Build the HTML representation of project card
     * @param {string} id 
     * @param {string} name 
     * @param {string} description 
     * @param {string} url 
     * @param {string} updated_at 
     * @param {string} created_at 
     * @param {string} language 
     * @param {string} has_page 
     * @returns 
     */
    function FormatProjectToHtml(id, name, description, url, updated_at, created_at, language, has_page) 
    {
        let githubPageUrl = (has_page == true) ? `<a class='btn btn-sm button-link' href='https://tonybloc.github.io/${name}/'><i class="fa fa-link fa-1g" aria-hidden="true"></i></a>` : '';
        
        let container = document.createElement('div');
        container.innerHTML = `<div class='col-xs-12 col-sm-6 col-md-6 col-lg-4'>
            <div class='project-card' data-toggle='modal' data-target='#${id}'>
                <img id='${id}-image'
                    class='image_projet img-responsive' 
                    src='./loader.gif' 
                    style='height: inherit;width: inherit;'/>
                <div class='overlay'>
                    <div class='text'>
                        <h4 class='projet_title'>${name}</h4>
                        <p class='projet_subtitle'>${description}</p>
                        <a class='btn btn-sm button-link' href='${url}'><i class="fa fa-github fa-1g" aria-hidden="true"></i></a>
                        ${githubPageUrl}
                        <p> ${created_at.substring(0, 10)}</p>
                    </div>
                </div>
            </div>`;
            /*
            <div class='modal fade' id='${id}' role='dialog'>
                <div class='vertical-alignment-helper'>
                    <div class='modal-dialog vertical-align-center'>
                        <!-- Modal content-->
                        <div class='modal-content'>
                            <div class='modal-header'>
                                <button type='button' class='close' data-dismiss='modal'>&times;</button>
                                <h4 class='modal-title'>${name}</h4>
                            </div>
                            <div class='modal-body'>
                                <div class='modal-description'>
                                    
                                    <h4 class='modal-subtitle'>Technologie utilisé</h4>
                                    <p>
                                        <p>Framework Materialize : Pour la mise en forme de l'application.</p>
                                        <p>Framework JQuery : Pour la validation des champs de saisie.</p>
                                        <p>Langage informatique : HTML, CSS, PHP, JS, SQL.</p>
                                    </p>
                                    <h4 class='modal-subtitle'>Déscription du projet</h4>
                                    <p>
                                        Mon rôle consistait à développer une interface d'administration Web permettant au responsable du  CDEV  d'évaluer mensuellement le travail des prestataires de la TMA.
                                        Les agents du services CDEV et les autres services informatiques peuvent, à l'aide de formulaires en ligne, répondre à l'enquête d'évaluation du travail des prestataires.
                                        Inversement, les prestataires de la TMA peuvent évaluer la collaboration et la qualité des données fournies par les agents d'Electrictié de Strasbourg lors des prestations effectuées.
                                    </p>
                                </div>
                            </div>
                            <div class='modal-footer'>
                                <button type='button' class='btn btn-default' data-dismiss='modal'>Quitter</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>`;
        */

        return container.firstChild;
    }
    
})();