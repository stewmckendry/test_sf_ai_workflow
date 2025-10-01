import { createElement } from 'lwc';
import HelloWorld from 'c/helloWorld';
import sayHello from '@salesforce/apex/HelloWorld.sayHello';

jest.mock('@salesforce/apex/HelloWorld.sayHello');

describe('c-hello-world', () => {
    afterEach(() => {
        // Clean up the DOM after each test
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('updates name property on handleNameChange', () => {
        const element = createElement('c-hello-world', {
            is: HelloWorld
        });
        document.body.appendChild(element);

        const input = element.shadowRoot.querySelector('input');
        input.value = 'John Doe';
        input.dispatchEvent(new CustomEvent('change'));

        expect(element.name).toBe('John Doe');
    });

    it('sets greeting property on successful handleClick', async () => {
        sayHello.mockResolvedValue('Hello, John Doe!');

        const element = createElement('c-hello-world', {
            is: HelloWorld
        });
        document.body.appendChild(element);
        element.name = 'John Doe';

        await element.handleClick();

        expect(element.greeting).toBe('Hello, John Doe!');
    });

    it('sets greeting property on handleClick error', async () => {
        sayHello.mockRejectedValue({ body: { message: 'Some error' } });

        const element = createElement('c-hello-world', {
            is: HelloWorld
        });
        document.body.appendChild(element);
        element.name = 'John Doe';

        await element.handleClick();

        expect(element.greeting).toBe('Error: Some error');
    });
});
