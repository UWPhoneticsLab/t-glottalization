const express = require('express');
const app = express();

const path = require('path');
const fs = require('fs');
const findFreePort = require('find-free-port');

findFreePort(3000, (err, freePort) => {

    if (err) throw err;
    const PORT = freePort;

    // Makes JSON request bodies accessible via req.body
    app.use(express.json());

    // Serve static files from the web/ directory
    app.use(express.static(path.join(__dirname, 'web')));

    // Set homepage to web/index.html
    app.get('/', (req, res) => {
        res.sendFile(path.join(__dirname, 'web', 'index.html'));
    });

    app.listen(PORT, () => {
        console.log(`Server is running on http://localhost:${PORT}`);
    });

    // GET /contents
    // Route to list web contents
    app.get('/contents', (req, res) => {

        function readDirRecursive(dir) {
            let results = {};
            const entries = fs.readdirSync(dir).filter(file => file !== '.DS_Store');
            entries.forEach(entry => {
                const fullPath = path.join(dir, entry);
                const stat = fs.statSync(fullPath);
                if (stat && stat.isDirectory()) {
                    results[entry] = readDirRecursive(fullPath);
                } else {
                    results[entry] = null;
                }
            });
            return results;
        }

        try {
            const directoryTree = readDirRecursive(path.join(__dirname, 'web'));
            res.json({ files: directoryTree });
        } catch (err) {
            console.error('Error reading directory:', err);
            res.status(500).send('Error reading directory');
        }
        return;
    });

    // POST /save
    // Route to save data from experiments
    app.post('/save', (req, res) => {

        // Output the request body for debugging purposes
        console.log(req.body);

        if (!req.body.filename || !req.body.data) {
            return res.status(500).json({ error: 'Missing filename or data in request body' });
        }

        // Set path where data will be stored
        // Note: OSF expects filename (all lowercase, so that’s what we use)
        const filePath = './data/' + req.body.filename;

        fs.writeFile(filePath, req.body.data, (err) => {
            if (err) {
                console.error('Error saving the file:', err);
                res.status(500).send('Error saving the data');
            } else {
                console.log('Data saved successfully');
                res.json({
                    success: true,
                    filePath: filePath,
                });
            }
        });
    });
});